//
//  FetchOneAccountResponse.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 11/03/2024.
//

import Foundation

struct SearchOneAccountResponse: Decodable{
    let status: Bool
    let statusCode: Int
    let message: String
    let data: AccountSearchData
}

struct AccountSearchData: Decodable{
    let account: AccountInfo
    let accountOwner: AccountOwner
}

struct AccountInfo: Decodable {
    let accountId: String = ""
    let accountType: String = ""
    let accountOwnerId: AccountOwner = AccountOwner()
    let accountNumber: String = ""
    let accountBalance: Double = 0.0
    let dateCreated: String = ""
}

struct AccountOwner: Decodable{
    let userId: String = ""
    let userName: String = ""
}
