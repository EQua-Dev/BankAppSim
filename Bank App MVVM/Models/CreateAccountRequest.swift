//
//  CreateAccountRequest.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 05/02/2024.
//

import Foundation

/*struct CreateAccountRequest: Codable{
    let name: String
    let accountType: String
    let balance: Double
}*/

struct CreateAccountRequest: Codable{
    let accountType: String
    let initialDeposit: Double
}
