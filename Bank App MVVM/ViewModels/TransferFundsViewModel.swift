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
    
    @Published var message: String? = ""
    @Published var accounts: [AccountViewModel] = [AccountViewModel]()
    
    var amount: String = ""
    var narration: String = ""
    
    //check if the amount entered to transfer is a valid numeric value
    private var isAmountValid: Bool {
        guard let transferAmount = Double(amount) else {
            return false
        }
        return transferAmount <= 0 ? false : true
    }
    
    // ensure that a selected account to send from is not available in the list of accounts to send to
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
    
    //unwrap and expose the account type of a selected 'fromAccount'
    var fromAccountType: String {
        fromAccount != nil ? fromAccount!.accountType : ""
    }
    
    //unwrap and expose the account type of a selected 'toAccount'
    var toAccountType: String{
        toAccount != nil ? toAccount!.accountType : ""
    }
    
    //unwrap and expose the account owner name of a selected 'fromAccount'
    var fromAccountName: String {
        fromAccount != nil ? fromAccount!.name : ""
    }
    
    //unwrap and expose the account owner name of a selected 'toAccount'
    var toAccountName: String{
        toAccount != nil ? toAccount!.name : ""
    }
    
    private func isValid() -> Bool{
        return isAmountValid
    }
    
    func submitTransfer(completion: @escaping () -> Void){
        
        if !isValid(){
            return
        }
        
        //ensure that there is a selected from and to accounts
        guard let fromAccount = fromAccount,
              let toAccount = toAccount,
              let transferAmount = Double(amount)else{
            return
        }
        
        
        let transferFundRequest = TransferFundRequest(accountFromId: fromAccount.accountId.lowercased(), accountToId: toAccount.accountId.lowercased(), amount: transferAmount)
        
        AccountService.shared.transferFunds(transferFundRequest: transferFundRequest){ result in
            
            switch(result){
                case .success(let response):
                    if response.success{
                        completion()
                    }else{
                        self.message = response.error
                    }
                case .failure(let error):
                    self.message = error.localizedDescription
                    print(error.localizedDescription)
            }
            
        }
    }
    
    //fetch all accounts
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
