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
    var accountId: String = ""
    var accountType: String = ""
    var accountOwnerId: AccountOwner = AccountOwner()
    var accountNumber: String = ""
    var accountBalance: Double = 0.0
    var dateCreated: String = ""
}

struct AccountOwner: Decodable{
    var userId: String = ""
    var userName: String = ""
}
