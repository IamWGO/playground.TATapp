//
//  UserDefaultManager.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-08.
//

import Foundation
import SwiftUI

let userDefaults = UserDefaults.standard

class UserDefaultManager {
    
    class func set(forKey: String, data: Any) {
        userDefaults.set(data, forKey: forKey)
        userDefaults.synchronize()
    }
    
    class func get(forKey: String) -> Any? {
        if let locallyData = userDefaults.object(forKey: forKey) {
           return locallyData
        } else {
            return nil
        }
    }
    
    class func remove(forKey: String) -> Bool {
        if let _ = userDefaults.object(forKey: forKey) {
            userDefaults.removeObject(forKey: forKey)
            userDefaults.synchronize()
            return true
        } else {
            return false
        }
    }
    
    class func isExist(forKey: String) -> Bool {
        if let _ = userDefaults.object(forKey: forKey) {
            return true
        } else {
            return false
        }
    }
    
    /*
    class func CheckUpdateVersion(completion: @escaping (_ isCompleted: Bool) -> Void) {
        let UserDefaultManager = UserDefaultManager()
        if (UserDefaultManager.currentVersion != version) {
            completion(true)
        } else {
            completion(false)
        }
    }*/
}

