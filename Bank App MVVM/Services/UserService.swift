//
//  UsereService.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 10/03/2024.
//

import Foundation

//enum NetworkError: Error{
//    case badUrl
//    case decodingError
//    case noData
//}

class UserService {

    
    //make the user service class to be a singleton (to prevent creation of multiple instances of it)
    private init() {}
    
    //create an instance of the user service class in order to make it accessible to others
    static let shared = UserService()
    
    func createUser(createUserRequest: CreateUserRequest, completion: @escaping(Result<CreateUserResponse, NetworkError>) -> Void){
        
        //set the url
        guard let url = URL.urlForSignUp() else{
            return completion(.failure(.badUrl))
        }
        
        //configure request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(createUserRequest)
        
        //make network request
        URLSession.shared.dataTask(with: request){ data, response, error in
            //unwrap the response data
            guard let data = data, error == nil else{
                return completion(.failure(.noData))
            }
            
            //decode the data
            let createUserResponse = try? JSONDecoder().decode(CreateUserResponse.self, from: data)
            if let createUserResponse = createUserResponse {
                completion(.success(createUserResponse))
            }else{
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
    
    func SignInUser(createUserRequest: CreateUserRequest, completion: @escaping(Result<SignInUserResponse, NetworkError>) -> Void){
        
        //set the url
        guard let url = URL.urlForSignIn() else{
            return completion(.failure(.badUrl))
        }
        
        //configure request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(createUserRequest)
        
        //make network request
        URLSession.shared.dataTask(with: request){ data, response, error in
            //unwrap the response data
            guard let data = data, error == nil else{
                return completion(.failure(.noData))
            }
            
            //decode the data
            let signInUserResponse = try? JSONDecoder().decode(SignInUserResponse.self, from: data)
            if let signInUserResponse = signInUserResponse {
                completion(.success(signInUserResponse))
            }else{
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
}
