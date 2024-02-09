//
//  TransferFundsViewModel.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 08/02/2024.
//

import Foundation

class TransferFundsViewModel: ObservableObject{
    
    var fromAccount: AccountViewModel?
    var toAccount: AccountViewModel?
    
    @Published var accounts: [AccountViewModel] = [AccountViewModel]()
    
    var filteredAccounts: [AccountViewModel] {
        if self.fromAccount == nil{
            return accounts
        }else{
            return accounts.filter{
                guard let fromAccount = self.fromAccount else{
                    return false
                }
                return $0.accountId != fromAccount.accountId
            }
        }
    }
    
    var fromAccountType: String {
        fromAccount != nil ? fromAccount!.accountType : ""
    }
    var toAccountType: String{
        toAccount != nil ? toAccount!.accountType : ""
    }
        
    var fromAccountName: String {
        fromAccount != nil ? fromAccount!.name : ""
    }
    var toAccountName: String{
        toAccount != nil ? toAccount!.name : ""
    }
    
    func populateAccounts(){
        
        AccountService.shared.getAllAccounts(){ result in
            switch(result){
                case .success(let accounts):
                    if let accounts = accounts{
                        DispatchQueue.main.async {
                            self.accounts = accounts.map(AccountViewModel.init)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        
        }
        
    }
    
    
}
