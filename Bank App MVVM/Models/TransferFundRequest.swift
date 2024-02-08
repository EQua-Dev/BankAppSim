//
//  TransferModel.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 08/02/2024.
//

import Foundation

struct TransferFundRequest: Codable{
    let accountFromId: String
    let accountToId: String
    let amount: String
}
