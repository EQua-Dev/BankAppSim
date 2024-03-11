//
//  CreateAccountViewModel.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 07/02/2024.
//

import Foundation


class CreateAccountViewModel: ObservableObject {
    
    var accountType: AccountType = .checking
    var initialDeposit: String = ""
    @Published var errorMessage: String = ""
    @Published var createdAccount: String = ""
    
    
}

extension CreateAccountViewModel{
    //input validation
   
    private var isInitialDepositValid: Bool {
        guard let userBalance = Double(initialDeposit) else {
            return false
        }
        return userBalance <= 0 ? false : true
    }
    
    private func isValid() -> Bool{
        var errors = [String]()
       
        if !isInitialDepositValid{
            errors.append("Initial Balance is not valid")
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

extension CreateAccountViewModel{
    
    func createAccount(completion: @escaping (Bool) -> Void){
        
        if !isValid() {return completion(false)}
        let createAccountReq = CreateAccountRequest(accountType: accountType.rawValue, initialDeposit: Double(initialDeposit)!)
  
        
        AccountService.shared.createAccount(createAccountRequest: createAccountReq){ result in
            switch (result) {
                case .success(let createAccountResponse):
                    if createAccountResponse.status{
                        DispatchQueue.main.async {
                            self.createdAccount = createAccountResponse.data.accountNumber
                        }
                        completion(true)
                    }else{
                        if let error = createAccountResponse.message{
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
