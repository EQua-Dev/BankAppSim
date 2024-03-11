//
//  AccountSummaryViewModel.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 04/02/2024.
//

import Foundation

class AccountSummaryViewModel: ObservableObject{
    
    private var _accountsModel = [AccountInfo]()
    
    @Published var accounts: [AccountViewModel] = [AccountViewModel]()
    
    //get the total of the account summary by mapping through all the accounts and adding the balance
    var total: Double{
        _accountsModel.map {$0.accountBalance}.reduce(0, +)
    }
    
    func getAllMyAccounts(){
        AccountService.shared.getAllMyAccounts{ result in
            switch result {
                case .success(let accounts):
                    if let accounts = accounts?.data {
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
    
    var account: AccountInfo
    
    init(account: AccountInfo) {
        self.account = account
    }
    
    //expose the various properties of the  account model
    
    var accountId: String{
        account.accountId
    }
    
    var accountType: String{
        account.accountType
    }
    
    var accountOwner: AccountOwner{
        account.accountOwnerId
    }
    
    var accountNumber: String{
        account.accountNumber
    }

    var accountBalance: Double{
        account.accountBalance
    }

    var accountDateCreated: String{
        account.dateCreated
    }
    
}

class AccountOwnerViewModel {
    
    var accountOwner: AccountOwner
    
    init(accountOwner: AccountOwner) {
        self.accountOwner = accountOwner
    }
    
    //expose the various properties of the  account owner model
    
    var accountOwnerId: String{
        accountOwner.userId
    }
    
    var accountOwnerName: String{
        accountOwner.userName
    }
    
}
