//
//  TransferFundsViewModel.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 08/02/2024.
//

import Foundation

class TransferFundsViewModel: ObservableObject{
    
    // var fromAccount: AccountViewModel?
    var transactionTo: String = ""
    var transactionFrom: String = ""
    
    var  transactionDate: String = ""
    
    var  accountNoToSearch: String = ""
    
    @Published var message: String? = ""
    @Published var accounts: [AccountViewModel] = [AccountViewModel]()
    @Published var searchedAccount: AccountInfo = AccountInfo()
    @Published var transactionReceipt: TransactionDetail = TransactionDetail()

    
    var transactionAmount: String = ""
    var transactionNarration: String = ""
    
    
    

}

extension TransferFundsViewModel{
    
    //validators
    
    private var isAccountNumberValid: Bool {
        accountNoToSearch.count == 10
    }
    //check if the amount entered to transfer is a valid numeric value
    private var isAmountValid: Bool {
        guard let transferAmount = Double(transactionAmount) else {
            return false
        }
        return transferAmount <= 0 ? false : true
    }

    private func isValid() -> Bool{
        return isAmountValid
    }
    
    private func isAccountNoValid(enteredAccountNumber: String) -> Bool{
        return enteredAccountNumber.count == 10
    }
    
}

extension TransferFundsViewModel{
    
    func searchOneAccount(completion: @escaping (Bool) -> Void){
        
        if !isAccountNoValid(enteredAccountNumber: accountNoToSearch){
            return completion(false)
        }
        AccountService.shared.searchOneAccount(accountNumber: accountNoToSearch){ result in
            
            switch (result){
                case .success(let account):
                    DispatchQueue.main.async {
                        self.searchedAccount = account.data.account
                    }
                    completion(true)
                    
                case .failure(let error):
                    print(error.localizedDescription)
            }
            
        }
    }
    
    func transferFunds(completion: @escaping () -> Void){
        
        if !isValid() || isAccountNoValid(enteredAccountNumber: transactionTo){
            return
        }
      
        
        let transferFundRequest = TransferFundRequest(transactionTo: transactionTo, transactionAmount: Double(transactionAmount)!, transactionNarration: transactionNarration, transactionDate: String.currentMillisTime())
        
        AccountService.shared.transferFunds(myAccountNumber: transactionFrom, transferFundRequest: transferFundRequest){ result in
        
                    switch(result){
                        case .success(let response):
                            if response.status{
                                DispatchQueue.main.async {
                                    self.transactionReceipt = response.data
                                }
                                completion()
                            }else{
                                self.message = response.message
                            }
                        case .failure(let error):
                            self.message = error.localizedDescription
                            print(error.localizedDescription)
                    }
        
                }
    }
    
    
}

