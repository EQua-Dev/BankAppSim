//
//  CreateAccountViewModel.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 07/02/2024.
//

import Foundation


class CreateAccountViewModel: ObservableObject {
    
    var accountType: AccountType = .current
    var initialDeposit: String = ""
    @Published var errorMessage: String = ""
    @Published var createdAccount: String = ""
    
    @Published var showAlert: Bool = false
    @Published var isLoading: Bool = false
    
    
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
                self.showAlert = true
                self.errorMessage = errors.joined(separator: "\n")
            }
            return false
        }
        
        return true
    }
}

extension CreateAccountViewModel{
    
    func createAccount(completion: @escaping (Bool) -> Void){
        
        self.isLoading = true
        if !isValid() {
            self.isLoading = false
            return completion(false)}
        let createAccountReq = CreateAccountRequest(accountType: accountType.rawValue, initialDeposit: Double(initialDeposit)!)
  
        print("Accounts Viewmodel")
        
        AccountService.shared.createAccount(createAccountRequest: createAccountReq){ result in
            switch (result) {
                case .success(let createAccountResponse):
                    if createAccountResponse.status{
                        DispatchQueue.main.async {
                            self.isLoading = false
                            self.createdAccount = createAccountResponse.data.accountNumber
                        }
                        completion(true)
                    }else{
                        if let error = createAccountResponse.message{
                            DispatchQueue.main.async {
                                self.isLoading = false
                                self.showAlert = true
                                self.errorMessage = error
                            }
                            completion(false)
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.isLoading = false
                        print(error.localizedDescription)
                    }
            }
            
        }
    }
    
}
