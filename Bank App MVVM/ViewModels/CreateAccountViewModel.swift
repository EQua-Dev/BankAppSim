//
//  CreateAccountViewModel.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 07/02/2024.
//

import Foundation


class CreateAccountViewModel: ObservableObject {
    
    var name: String = ""
    var accountType: AccountType = .checking
    var balance: String = ""
    @Published var errorMessage: String = ""
    
}

extension CreateAccountViewModel{
    //input validation
    private var isNameValid: Bool {
        !name.isEmpty
    }
    private var isBalanceValid: Bool {
        guard let userBalance = Double(balance) else {
            return false
        }
        return userBalance <= 0 ? false : true
    }
    
    private func isValid() -> Bool{
        var errors = [String]()
        
        if !isNameValid{
            errors.append("Name is not valid")
        }
        if !isBalanceValid{
            errors.append("Balance is not valid")
        }
        if !errors.isEmpty {
            self.errorMessage = errors.joined(separator: "\n")
            return false
        }
        
        return true
    }
}

extension CreateAccountViewModel{
    
    func createAccount(completion: @escaping (Bool) -> Void){
        
        if !isValid() {return completion(false)}
        let createAccountReq = CreateAccountRequest(name: name, accountType: accountType.rawValue, balance: Double(balance)!)
        
        AccountService.shared.createAccount(createAccountRequest: createAccountReq){ result in
            switch result {
                case .success(let createAccountResponse):
                    if createAccountResponse.success{
                        completion(true)
                    }else{
                        if let error = createAccountResponse.error{
                            self.errorMessage = error
                            completion(false)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
            
        }
    }
    
}
