//
//  String+Extensions.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 11/03/2024.
//

import Foundation

extension String{
    
    static func AUTH_TOKEN_KEY() -> String {
        return "AuthToken"
    }

    static func authToken() -> String?{
        return UserDefaults.standard.string(forKey: AUTH_TOKEN_KEY()) ?? ""
    }
    
    static func currentMillisTime() -> String{
        let currentTimeMillis = Date().timeIntervalSince1970 * 1000
        return String(currentTimeMillis)
    }
}
