//
//  Account.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 03/02/2024.
//

import Foundation

enum AccountType: String, Codable, CaseIterable{
    case checking
    case saving
}

    //create an extension of the AccountType enum that conditionally sets the value
extension AccountType{
    var title: String {
        switch self {
            case .checking:
                return "Checking"
            case .saving:
                return "Saving"
        }
    }
}

struct Account: Codable{
    var id: String
    var name: String
    let accountType: AccountType
    var balance: Double
}
