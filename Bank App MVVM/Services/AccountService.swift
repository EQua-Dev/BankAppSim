//
//  AccountService.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 04/02/2024.
//

import Foundation

enum NetworkError: Error{
    case badUrl
    case decodingError
    case noData
}

class AccountService {
    
    //make the account service class to be a singleton (to prevent creation of multiple instances of it)
    private init() {}
    
    //create an instance of the account service class in order to make it accessible to others
    static let shared = AccountService()
    
    func getAllAccounts(completion: @escaping (Result<[Account]?, NetworkError>) -> Void){
        
        //set the url
        guard let url = URL.urlForAccounts() else {
            return completion(.failure(.badUrl))
        }
        
        //make the network request
        URLSession.shared.dataTask(with: url){ data, response, error in
            
            //unwrap the response data
            guard let data = data, error == nil else{
                return completion(.failure(.noData))
            }
            //decode the data
            let accounts = try? JSONDecoder().decode([Account].self, from: data)
            if accounts == nil {
                completion(.failure(.decodingError))
            }else{
                completion(.success(accounts))
            }
            
        }.resume()
    }
}
