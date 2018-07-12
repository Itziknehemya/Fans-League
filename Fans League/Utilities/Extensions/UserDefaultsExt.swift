//
//  UserDefaultsExt.swift
//  Fans League
//
//  Created by itzik nehemya on 11/07/2018.
//  Copyright © 2018 Nehemya. All rights reserved.
//

import Foundation
extension UserDefaults {
    @discardableResult
    static func save(value: Any, forKey key: String) -> UserDefaults {
        UserDefaults.standard.set(value, forKey: key)
        return UserDefaults.standard
    }
    
    @discardableResult
    static func remove(key: String) -> UserDefaults {
        UserDefaults.standard.set(nil, forKey: key)
        UserDefaults.standard.removeObject(forKey: key)
        return UserDefaults.standard
    }
    
    static func load(key: String, defaultValue: Any? = nil) -> Any? {
        if let actualValue = UserDefaults.standard.object(forKey: key) {
            return actualValue as AnyObject?
        }
        
        return defaultValue
    }
}
