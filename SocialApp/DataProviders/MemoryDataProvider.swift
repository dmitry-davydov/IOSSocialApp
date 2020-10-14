//
//  MemoryDataProvider.swift
//  SocialApp
//
//  Created by Дима Давыдов on 04.10.2020.
//

import Foundation

protocol IDProtocol {
    func getID() -> String
}

class MemoryDataProvider<T:IDProtocol> {
 
    private var data: [T] = []
    
    var count: Int {
        return data.count
    }
    
    func getData() -> [T] {
        return data
    }
    
    func addDataItem(item: T) -> Self {
        data.append(item)
        
        return self
    }
    
    subscript(index: Int) -> T? {
        return data[index]
    }
    
    func getByID(id: String) -> Optional<T> {
        for item in data {
            if item.getID() != id { continue }
            
            return item
        }
        
        return nil
    }
    
    func hasItem(id: String) -> Bool {
        for item in data {
            if item.getID() != id { continue }
            
            return true
        }
        
        return false
    }
}

