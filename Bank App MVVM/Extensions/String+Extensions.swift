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
 
    static func USER_NAME_KEY() -> String {
        return "Username"
    }

    static func userName() -> String?{
        return UserDefaults.standard.string(forKey: USER_NAME_KEY()) ?? ""
    }
    
      static func authToken() -> String?{
        return UserDefaults.standard.string(forKey: AUTH_TOKEN_KEY()) ?? ""
    }
    
    static func currentMillisTime() -> String{
        let currentTimeMillis = Date().timeIntervalSince1970 * 1000
        return String(currentTimeMillis)
    }
    
    static func generateGreeting(/*name: String*/) -> String {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        var greeting = ""
        
        switch hour {
        case 0..<12:
            greeting = "Good morning"
        case 12..<18:
            greeting = "Good afternoon"
        default:
            greeting = "Good evening"
        }
        
        return "\(greeting)"
    }
    
    static func formatDate(milliseconds: Int64, format: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: date)
    }
}
