//
//  ImageCacheService.swift
//  SocialApp
//
//  Created by Дима Давыдов on 18.01.2021.
//

import Foundation

class CacheService {
    
    let category: String
    
    private var rootDirectory: URL {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent(category)
    }
    
    init(category: String) {
        self.category = category
        createDirectoryIfNotExists()
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
        let isExists = FileManager.default.fileExists(atPath: getCachedFilePath(from: url))
        print("[CacheService] isFileExists: \(url.relativePath) exists: \(isExists)")
        return isExists
    }
    
    fileprivate func getCachedFilePath(from url: URL) -> String {
        let path = rootDirectory.appendingPathComponent(getHashedFile(from: url)).path
        print("[CacheService] getCachedFilePath: \(path)")
        return path
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
        return "\(self.hash(external: url))"
    }
    
    // захешировать url
    fileprivate func hash(external url: URL) -> String {
        return url.relativePath.split(separator: "/").joined(separator: "_")
    }
}
