//
//  MemoryDataProvider.swift
//  SocialApp
//
//  Created by Дима Давыдов on 04.10.2020.
//

import Foundation

class MemoryDataProvider<T> {
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
}
