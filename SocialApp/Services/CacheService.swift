//
//  ImageCacheService.swift
//  SocialApp
//
//  Created by Дима Давыдов on 18.01.2021.
//

import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

class CacheService {
    
    let category: String
    
    private var rootDirectory: URL {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent(category)
    }
    
    init(category: String) {
        self.category = category
    }
    
    fileprivate func createDirectoryIfNotExists() {
        if FileManager.default.fileExists(atPath: rootDirectory.path) { return }
        // создать директорию
        try? FileManager.default.createDirectory(at: rootDirectory, withIntermediateDirectories: true, attributes: nil)
    }
    
    // метод для сохранения файла
    func saveCachedFile(by url: URL, data: Data?) -> Bool {
        return FileManager.default.createFile(atPath: getCachedFilePath(from: url) , contents: data, attributes: nil)
    }
    
    // метод для чтения файла
    func readCachedFile(from url: URL) -> Data? {
        return FileManager.default.contents(atPath: getCachedFilePath(from: url))
    }
    
    // метод для проверки наличия файла в кеше
    func isFileExists(url: URL) -> Bool {
        return FileManager.default.fileExists(atPath: getCachedFilePath(from: url))
    }
    
    fileprivate func getCachedFilePath(from url: URL) -> String {
        return rootDirectory.appendingPathComponent(getHashedFile(from: url)).path
    }
    
    // получить время создания файла в кеше
    func getFileCreated(for url: URL) -> Int {
        
        guard let info = try? FileManager.default.attributesOfItem(atPath: getCachedFilePath(from: url)),
              let modificationDate = info[FileAttributeKey.modificationDate] as? Date else {
            return 0
        }
        
        return Int(modificationDate.timeIntervalSince1970)
    }
    
    func deleteFile(url: URL) {
        try? FileManager.default.removeItem(atPath: getCachedFilePath(from: url))
    }
    
    fileprivate func getHashedFile(from url: URL) -> String {
        return "\(self.hash(external: url)).\(getExt(url: url))"
    }
    
    // захешировать url
    fileprivate func hash(external url: URL) -> String {
        return MD5(string: url.path).map { String(format: "%02hhx", $0) }.joined()
    }
    
    fileprivate func getExt(url: URL) -> String {
        return url.path.split(separator: ".").last!.base
    }
}

private func MD5(string: String) -> Data {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData
    }
