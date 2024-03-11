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
    let transactionID: String = ""
    let transactionTime: String = ""
    let transactionAmount: Double = 0.0
    let transactionNarration: String = ""
    let transactionReceiver: AccountInfo = AccountInfo()
    let transactionSender: AccountInfo = AccountInfo()
}


