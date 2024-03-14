//
//  TransferFundResponse.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 08/02/2024.
//

import Foundation

struct TransferFundResponse: Decodable{
    let status: Bool
    let statusCode: Int
    let message: String
    let data: TransactionDetail
}

struct TransactionDetail: Decodable{
    var transactionID: String = ""
    var transactionTime: String = ""
    var transactionAmount: Double = 0.0
    var transactionNarration: String = ""
    var transactionReceiver: AccountInfo = AccountInfo()
    var transactionSender: AccountInfo = AccountInfo()
}


