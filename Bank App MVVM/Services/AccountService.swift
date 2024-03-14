//
//  AccountService.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 04/02/2024.
//

import Foundation

enum NetworkError: Error{
    case badUrl
    case authenticationError
    case decodingError
    case noData
}

class AccountService {
    
    //make the account service class to be a singleton (to prevent creation of multiple instances of it)
    private init() {}
    
    //create an instance of the account service class in order to make it accessible to others
    static let shared = AccountService()
    
    /// This function creates a bank account for the logged in user
    /// - Parameters:
    ///   - createAccountRequest: JSON body containing accountType and initialDepositAmount
    ///   - completion: returns either a case from the NetworkError enum or a CreateAccountResponse JSON data
    func createAccount(createAccountRequest: CreateAccountRequest, completion: @escaping(Result<CreateAccountResponse, NetworkError>) -> Void){
        //set the url
        guard let url = URL.urlForCreateAccount() else{
            return completion(.failure(.badUrl))
        }
        
        //configure request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(String.authToken()!)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(createAccountRequest)
        
        
        //make network request
        URLSession.shared.dataTask(with: request){ data, response, error in
            //unwrap the response data
            guard let data = data, error == nil else{
                return completion(.failure(.noData))
            }
            
            //decode the data
            let createAccountResponse = try? JSONDecoder().decode(CreateAccountResponse.self, from: data)
            if let createAccountResponse = createAccountResponse {
                completion(.success(createAccountResponse))
            }else{
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
    
    func getAllMyAccounts(completion: @escaping (Result<GetMyAccountsResponse?, NetworkError>) -> Void){
        
        //set the url
        guard let url = URL.urlForFetchAllAccountsOfUser() else {
            return completion(.failure(.badUrl))
        }
        
        guard let userToken = String.authToken() else {
                return completion(.failure(.authenticationError))
            }

        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")

                
        //make the network request
        URLSession.shared.dataTask(with: request){ data, response, error in
            
            print("Account \(response!)")
            //unwrap the response data
            guard let data = data, error == nil else{
                return completion(.failure(.noData))
            }
            //decode the data
            let accounts = try? JSONDecoder().decode(GetMyAccountsResponse.self, from: data)
            if accounts == nil {
                completion(.failure(.decodingError))
            }else{
                completion(.success(accounts))
            }
            
        }.resume()
    }
    
    func searchOneAccount(accountNumber: String, completion: @escaping(Result<SearchOneAccountResponse, NetworkError>) -> Void) {
        
        //set the url
        guard let url = URL.urlForFetchAccountDetails(accountNo: accountNumber) else{
            return completion(.failure(.badUrl))
        }
        
        //configure request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(String.authToken()!)", forHTTPHeaderField: "Authorization")

        //make network request
        URLSession.shared.dataTask(with: request){ data, response, error in
            //unwrap the response data
            guard let data = data, error == nil else{
                return completion(.failure(.noData))
            }
            
            print("data decoding stage")
            
            //decode the data
            let searchAccountResponse = try? JSONDecoder().decode(SearchOneAccountResponse.self, from: data)
            if let searchAccountResponse = searchAccountResponse {
                completion(.success(searchAccountResponse))
            }else{
                completion(.failure(.decodingError))
            }
            
        }.resume()
        
    }
    
    func transferFunds(myAccountNumber: String, transferFundRequest: TransferFundRequest, completion: @escaping(Result<TransferFundResponse, NetworkError>) -> Void){
        
        //set the url
        guard let url = URL.urlForTransferFunds(myAccountNo: myAccountNumber) else{
            return completion(.failure(.badUrl))
        }
        
        //configure request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(String.authToken()!)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(transferFundRequest)
        
        //make network request
        URLSession.shared.dataTask(with: request){ data, response, error in
            //unwrap the response data
            guard let data = data, error == nil else{
                return completion(.failure(.noData))
            }
            
            print("data decoding stage")
            
            //decode the data
            let transferFundsResponse = try? JSONDecoder().decode(TransferFundResponse.self, from: data)
            if let transferFundsResponse = transferFundsResponse {
                completion(.success(transferFundsResponse))
            }else{
                completion(.failure(.decodingError))
            }
            
        }.resume()
        
    }
    
}
