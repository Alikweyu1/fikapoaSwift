//
//  OrderlyDictionary.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 23/03/2023.
//

import Foundation
struct OrderedDictionary<Key: Hashable, Value> {
    private var keys: [Key] = []
    private var values: [Key: Value] = [:]
    
    var count: Int {
        return keys.count
    }
    
    subscript(key: Key) -> Value? {
        get {
            return values[key]
        }
        set(newValue) {
            if newValue == nil {
                removeValue(forKey: key)
            } else {
                updateValue(newValue!, forKey: key)
            }
        }
    }
    
    mutating func updateValue(_ value: Value, forKey key: Key) -> Value? {
        if let existingValue = values[key] {
            let index = keys.index(of: key)!
            values[key] = value
            return existingValue
        } else {
            keys.append(key)
            values[key] = value
            return nil
        }
    }
    
    mutating func removeValue(forKey key: Key) -> Value? {
        guard let index = keys.index(of: key) else { return nil }
        keys.remove(at: index)
        return values.removeValue(forKey: key)
    }
    
    subscript(index: Int) -> (Key, Value) {
        let key = keys[index]
        let value = values[key]!
        return (key, value)
    }
}
