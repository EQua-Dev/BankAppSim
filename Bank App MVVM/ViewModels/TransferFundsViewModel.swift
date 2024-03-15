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
    
    @Published var errorMessage: String = ""


    
    var transactionAmount: String = ""
    var transactionNarration: String = ""
    
    @Published var showAlert: Bool = false
    @Published var isLoading: Bool = false
    
    
    

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
        
        self.isLoading = true
        
        if !isAccountNoValid(enteredAccountNumber: accountNoToSearch){
            self.isLoading = false
            return completion(false)
        }
        AccountService.shared.searchOneAccount(accountNumber: accountNoToSearch){ result in
            
            switch (result){
                case .success(let account):
                    DispatchQueue.main.async {
                        self.searchedAccount = account.data.account
                        self.isLoading = false
                    }
                    completion(true)
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                    print(error.localizedDescription)
            }
            
        }
    }
    
    func transferFunds(myAccountNumber: String, theirAccountNumber: String, completion: @escaping (Bool) -> Void){
        
        self.isLoading = true
        
        if !isValid() || isAccountNoValid(enteredAccountNumber: transactionTo){
            self.isLoading = false
            return completion(false)
        }
      
        
        let transferFundRequest = TransferFundRequest(transactionTo: theirAccountNumber, transactionAmount: Double(transactionAmount)!, transactionNarration: transactionNarration, transactionDate: String.currentMillisTime())
        
        print("request body: \(transferFundRequest)")
        
        AccountService.shared.transferFunds(myAccountNumber: myAccountNumber, transferFundRequest: transferFundRequest){ result in
        
                    switch(result){
                        case .success(let response):
                            if response.status{
                                DispatchQueue.main.async {
                                    self.transactionReceipt = response.data
                                    self.isLoading = false
                                }
                                completion(true)
                            }else{
                                DispatchQueue.main.async {
                                    self.errorMessage = response.message
                                    self.isLoading = false
                                }
                                completion(false)
                            }
                        case .failure(let error):
                            DispatchQueue.main.async {
                                self.showAlert = true
                                self.errorMessage = error.localizedDescription
                                self.isLoading = false
                            }
                            print(error.localizedDescription)
                            completion(false)
                    }
        
                }
    }
    
    
}

