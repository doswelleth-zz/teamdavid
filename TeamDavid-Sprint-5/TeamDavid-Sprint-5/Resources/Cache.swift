//
//  Cache.swift
//  TeamDavid-Sprint-5
//
//  Created by David Doswell on 12/23/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class Cache<Key: Hashable, Value> {
    
    private var cache = [Key : Value]()
    private let queue = DispatchQueue(label: "com.doswelloliverdavid.RandomUsers.CacheQueue")
    
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
    
}

