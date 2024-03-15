//
//  TransferFundsScreen.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 09/02/2024.
//

import SwiftUI

struct TransferFundsScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject private var transferFundsVM = TransferFundsViewModel()
    
    let account: AccountInfo
    
    @State private var showSheet = false
    @State private var isFromAccount = false
    @State private var isToAccount = false
    @State private var accountFound: Bool? = nil
    @State private var showError: Bool = false
    
    
    /*   var actionSheetButtons: [Alert.Button]{
     var actionButtons = self.transferFundsVM.filteredAccounts.map{ account in
     Alert.Button.default(Text("\(account.name) (\(account.accountType))")){
     if self.isFromAccount{
     self.transferFundsVM.fromAccount = account
     }else{
     self.transferFundsVM.toAccount = account
     }
     }
     }
     
     actionButtons.append(.cancel())
     return actionButtons
     } */
    
    var body: some View {
        GeometryReader{ geometry in
            ScrollView{
                VStack{
                    //Text("Transfer Funds").font(.system(size: 24))
                    
                    HStack{
                        TextField("Account Number", text: self.$transferFundsVM.accountNoToSearch)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(5.0)
                            .padding(.horizontal, 15)
                            .frame(minWidth: 0, maxWidth: .infinity)
                        
                        CustomButton(action: {
                            transferFundsVM.searchOneAccount{success in
                                if success{
                                    accountFound = true
                                }else{
                                    accountFound = false
                                    showError = true
                                }
                                
                            }
                        }, buttonTitle: "Search", width: 100)
                    }.padding()
                    if accountFound ?? false{
                        searchedAccountView(searchedAccount: transferFundsVM.searchedAccount)
                    }else if showError{
                        Text("Account Not Found!").foregroundColor(.red).bold().padding()
                    }
                    //TransferFundsAccountSelectionButtons(transferFundsVM: self.transferFundsVM, showSheet: $showSheet, isFromAccount: $isFromAccount, isToAccount: $isToAccount).frame(height: 300)
                    Spacer()
                    TextField("Amount", text: self.$transferFundsVM.transactionAmount)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5.0)
                        .padding(.horizontal)
                        .frame(minWidth: 0, maxWidth: .infinity)
                    
                    TextField("Narration", text: self.$transferFundsVM.transactionNarration)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5.0)
                        .padding(.horizontal)
                        .frame(minWidth: 0, maxWidth: .infinity)
                    //show error message from the transaction if any
                    Text(self.transferFundsVM.message ?? "")
                    
                    CustomButton(action: {
                        
                        transferFundsVM
                            .transferFunds(myAccountNumber: account.accountNumber, theirAccountNumber: transferFundsVM.searchedAccount.accountNumber){success in
                                if success{
                                    // print(data.)
                                    print(success)
                                }else{
                                    
                                }
                                
                            }
                    }, buttonTitle: "Transfer", width: 220)
                    
                    .alert(isPresented: $transferFundsVM.showAlert) {
                        Alert(title: Text("Error"), message: Text("\(transferFundsVM.errorMessage)"), dismissButton: .default(Text("OK")))
                    }
                    
                    /* Button("Submit Transfer"){
                     self.transferFundsVM.transferFunds{ success in
                     if success{
                     //dismiss sheet
                     self.presentationMode.wrappedValue.dismiss()
                     }else{
                     
                     }
                     }
                     }.padding()*/
                    
                }
                if transferFundsVM.isLoading{
                    LoadingIndicatorView(loadingMessage: "Transferring...")
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
        }
        .navigationBarTitle("Transfer Funds").embedInNavigationView()
    }
}
private func searchedAccountView(searchedAccount: AccountInfo) -> some View{
    
    return HStack{
        VStack(alignment: .leading) {
            Text("Account Name: \(searchedAccount.accountOwnerId.userName)").font(.headline).padding(.horizontal)
            Text("A/C No: \(searchedAccount.accountNumber)").font(.subheadline).padding(.horizontal)
        }
        VStack{
            Text("\(searchedAccount.accountType)").padding().bold()
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}



/*struct TransferFundsScreen_Previews: PreviewProvider {
 static var previews: some View {
 TransferFundsScreen()
 }
 }*/


