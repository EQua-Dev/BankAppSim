//
//  CreateAccountResponse.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 05/02/2024.
//

import Foundation

struct CreateAccountResponse: Decodable{
    let success: Bool
    let error: String?
}
