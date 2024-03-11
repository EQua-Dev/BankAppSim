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
    @Published var errorMessage: String = ""
    
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
        if !errors.isEmpty {
            DispatchQueue.main.async {
                self.errorMessage = errors.joined(separator: "\n")
            }
            return false
        }
        
        return true
    }
}

extension CreateUserViewModel{
    
    func createAccount(completion: @escaping (Bool) -> Void){
        
        if !isValid() {return completion(false)}
        let createUserReq = CreateUserRequest(username: username, password: password)
        
        UserService.shared.createUser(createUserRequest: createUserReq){ result in
            switch result {
                case .success(let createUserResponse):
                    if createUserResponse.status{
                        completion(true)
                    }else{
                        if let error = createUserResponse.message{
                            DispatchQueue.main.async {
                                self.errorMessage = error
                            }
                            completion(false)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
}
