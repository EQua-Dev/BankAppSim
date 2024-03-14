//
//  CreateUserResponse.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 10/03/2024.
//

import Foundation
struct CreateUserResponse: Decodable{
    
    let status: Bool
    let statusCode: Int
    let message: String!
    let data: String
    
}

struct SignInUserResponse: Decodable{
    let status: Bool
    let statusCode: Int
    let message: String!
    let data: SignInToken
}

struct SignInToken: Decodable{
    let token: String
    let username: String
}
