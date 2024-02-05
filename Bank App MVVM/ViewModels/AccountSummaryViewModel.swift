//
//  AccountSummaryViewModel.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 04/02/2024.
//

import Foundation

class AccountSummaryViewModel: ObservableObject{
    
    private var _accountsModel = [Account]()
    
    @Published var accounts: [AccountViewModel] = [AccountViewModel]()
    
    //get the total of the account summary by mapping through all the accounts and adding the balance
    var total: Double{
        _accountsModel.map {$0.balance}.reduce(0, +)
    }
    
    func getAllAccounts(){
        AccountService.shared.getAllAccounts{ result in
            switch result {
                case .success(let accounts):
                    if let accounts = accounts{
                        self._accountsModel = accounts
                        DispatchQueue.main.async {
                            self.accounts = accounts.map(AccountViewModel.init)
                        }
                    }
                    print("success")
                case .failure(let error):
                    print(error.localizedDescription)
            }
            
        }
    }
    
}

class AccountViewModel {
    
    var account: Account
    
    init(account: Account) {
        self.account = account
    }
    
    //expose the various properties of the  account model
    
    var name: String{
        account.name
    }
    
    var accountId: String{
        account.id
    }
    
    var accountType: String{
        account.accountType.title
    }

    var balance: Double{
        account.balance
    }
    
}
