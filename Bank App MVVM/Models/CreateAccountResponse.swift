//
//  CreateAccountResponse.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 05/02/2024.
//

import Foundation

struct CreateAccountResponse: Decodable{
    let status: Bool
    let statusCode: Int
    let message: String!
    let data: CreatedAccount
}

struct CreatedAccount: Decodable{
    let userId: String
    let accountNumber: String
    let accountBalance: Double
}
