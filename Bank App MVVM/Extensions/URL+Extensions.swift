//
//  URL+Extensions.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 03/02/2024.
//

import Foundation
extension URL {
    
    static func urlForAccounts() -> URL? {
         return URL(string: "https://wood-pushy-buckthornpepperberry.glitch.me/api/accounts")
    }
    
    static func urlForCreateAccounts() -> URL? {
        return URL(string: "https://wood-pushy-buckthornpepperberry.glitch.me/api/accounts")
    }
}
