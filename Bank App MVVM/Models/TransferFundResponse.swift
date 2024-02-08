//
//  TransferFundResponse.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 08/02/2024.
//

import Foundation

struct TransferFundResponse: Decodable{
    let success: Bool
    let error: String?
}
