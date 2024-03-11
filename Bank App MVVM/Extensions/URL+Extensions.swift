//
//  URL+Extensions.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 03/02/2024.
//

import Foundation
var baseUrl = "http://0.0.0.0:8080/"
extension URL {
    
   
    
    static func urlForAccounts() -> URL? {
         return URL(string: "https://wood-pushy-buckthornpepperberry.glitch.me/api/accounts")
    }
    
    static func urlForCreateAccounts() -> URL? {
        return URL(string: "https://wood-pushy-buckthornpepperberry.glitch.me/api/accounts")
    }
    
//    static func urlForTransferFunds() -> URL? {
//        return URL(string: "https://wood-pushy-buckthornpepperberry.glitch.me/api/transfer")
//    }
    
    static func urlForSignUp() -> URL? {
        return URL(string: "\(baseUrl)signup")
    }
    
    static func urlForSignIn() -> URL? {
        return URL(string: "\(baseUrl)signin")
    }
    
    static func urlForCreateAccount() -> URL? {
        return URL(string: "\(baseUrl)create-account")
    }
    
    static func urlForFetchAllAccountsOfUser() -> URL? {
        return URL(string: "\(baseUrl)my-accounts")
    }
    
    static func urlForFetchAccountDetails(accountNo: String) -> URL? {
        return URL(string: "\(baseUrl)find-account/\(accountNo)")
    }
    
    static func urlForTransferFunds(myAccountNo: String) -> URL? {
        return URL(string: "\(baseUrl)transfer-funds/\(myAccountNo)")
    }
    
    static func urlForFetchTransferHistory() -> URL? {
        return URL(string: "\(baseUrl)my-transfer-history")
    }
    
}
