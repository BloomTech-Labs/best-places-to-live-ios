//
//  Cache.swift
//  BestPlaceToLive
//
//  Created by Luqmaan Khan on 12/6/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation
class Cache<Key: Hashable, Value> {
    
    func cache(value: Value, for key: Key) {
        queue.async {
            self.cache[key] = value
        }
    }
    
    func value(for key: Key) -> Value? {
        return queue.sync { cache[key] }
    }
    
    func clear() {
        queue.async {
            self.cache.removeAll()
        }
    }
    
    private var cache = [Key : Value]()
    private let queue = DispatchQueue(label: "CacheQueue")
}
