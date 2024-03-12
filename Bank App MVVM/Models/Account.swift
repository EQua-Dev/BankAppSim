//
//  Account.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 03/02/2024.
//

import Foundation

enum AccountType: String, Codable, CaseIterable{
    case current
    case saving
    case student
}

    //create an extension of the AccountType enum that conditionally sets the value
extension AccountType{
    var title: String {
        switch self {
            case .current:
                return "Current"
            case .saving:
                return "Saving"
            case .student:
                return "Student"
        }
    }
}

struct Account: Codable{
    var id: UUID
    var name: String
    let accountType: AccountType
    var balance: Double
}

struct GetMyAccountsResponse: Decodable{
    let status: Bool
    let statusCode: Int
    let message: String
    let data: [AccountInfo]
}

