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
    @State private var accountFound = false
    
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
                                print("false")
                            }
                            
                        }
                    }, buttonTitle: "Search", width: 100)
                }.padding()
                if accountFound{
                    searchedAccountView(searchedAccount: transferFundsVM.searchedAccount)
                }else{
                    Text("Account Not Found!").foregroundColor(.red).bold().padding()
                }
                //TransferFundsAccountSelectionButtons(transferFundsVM: self.transferFundsVM, showSheet: $showSheet, isFromAccount: $isFromAccount, isToAccount: $isToAccount).frame(height: 300)
                Spacer()
                //show error message from the transaction if any
                Text(self.transferFundsVM.message ?? "")
                
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
        }
        .navigationBarTitle("Transfer Funds").embedInNavigationView()
    }
}
private func searchedAccountView(searchedAccount: AccountInfo) -> some View{
    
    return HStack{
        VStack {
            Text("A/C No: \(searchedAccount.accountOwnerId.userName)").font(.title).fontWeight(.bold).padding(.horizontal)
            Text("Name: \(searchedAccount.accountNumber)").font(.headline).padding(.horizontal)
        }
        VStack{
            Text("Name: \(searchedAccount.accountType)").padding()
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


