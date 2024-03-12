//
//  CreateUserViewModel.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 10/03/2024.
//

import Foundation

class CreateUserViewModel: ObservableObject {
    
    var username: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    @Published var errorMessage: String = ""
    @Published var showAlert: Bool = false
    @Published var isLoading: Bool = false
    
}

extension CreateUserViewModel{
    //input validation
    private var isUserNameValid: Bool {
        !username.isEmpty
    }
    private var isPasswordValid: Bool {
        password.count >= 8
    }
    private var isPasswordStrong: Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[^A-Za-z\\d]).{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    private var isPasswordSame: Bool{
        password == confirmPassword
    }
    
    private func isValidSignIn() -> Bool{
        var errors = [String]()
        if !isUserNameValid{
            errors.append("Name is not valid")
        }
        if !isPasswordValid{
            errors.append("Password must be at least 8 characters")
        }
        
        if !errors.isEmpty {
            DispatchQueue.main.async {
                self.showAlert = true
                self.errorMessage = errors.joined(separator: "\n")
            }
            return false
        }
        
        return true
    }
    
    private func isValid() -> Bool{
        var errors = [String]()
        
        if !isUserNameValid{
            errors.append("Name is not valid")
        }
        if !isPasswordValid{
            errors.append("Password must be at least 8 characters")
        }
        if !isPasswordStrong{
            errors.append("Password must contain at least one uppercase, one lowercase, one number, one alphabet, and one special character")
        }
        if !isPasswordSame{
            errors.append("Password does not match")
        }
        if !errors.isEmpty {
            DispatchQueue.main.async {
                self.showAlert = true
                self.errorMessage = errors.joined(separator: "\n")
            }
            return false
        }
        
        return true
    }
}

extension CreateUserViewModel{
    
    func createAccount(completion: @escaping (Bool) -> Void){
        
        self.isLoading = true
        
        if !isValid() {
            self.isLoading = false
            return completion(false)}
        let createUserReq = CreateUserRequest(username: username, password: password)
        
        UserService.shared.createUser(createUserRequest: createUserReq){ result in
            switch result {
                case .success(let createUserResponse):
                    self.isLoading = false
                    if createUserResponse.status{
                        completion(true)
                    }else{
                        if let error = createUserResponse.message{
                            DispatchQueue.main.async {
                                self.isLoading = false
                                self.errorMessage = error
                            }
                            completion(false)
                        }
                    }
                case .failure(let error):
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                    print(error.localizedDescription)
            }
        }
    }
    
    func signInUser(completion: @escaping (Bool) -> Void){
        
        self.isLoading = true
        
        if !isValidSignIn() {
            self.isLoading = false
            return completion(false)}
        let createUserReq = CreateUserRequest(username: username, password: password)
        
        UserService.shared.signInUser(createUserRequest: createUserReq){ result in
            switch result {
                case .success(let signInUserResponse):
                    if signInUserResponse.status{
                        DispatchQueue.main.async {
                            self.isLoading = false
                        }
                        completion(true)
                    }else{
                        if let error = signInUserResponse.message{
                            DispatchQueue.main.async {
                                self.isLoading = false
                                self.errorMessage = error
                            }
                            completion(false)
                        }
                    }
                case .failure(let error):
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                    print(error.localizedDescription)
            }
        }
    }
    
}
