//
//  TransferFundsScreen.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 09/02/2024.
//

import SwiftUI

struct TransferFundsScreen: View {
    
    @ObservedObject private var transferFundsVM = TransferFundsViewModel()
    
    @State private var showSheet = false
    @State private var isFromAccount = false
    @State private var isToAccount = false
    
    var actionSheetButtons: [Alert.Button]{
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
    }
    
    var body: some View {
        VStack{
            AccountListView(accounts: self.transferFundsVM.accounts)
            TransferFundsAccountSelectionButtons(transferFundsVM: self.transferFundsVM, showSheet: $showSheet, isFromAccount: $isFromAccount, isToAccount: $isToAccount).frame(height: 300)
            Spacer()
            .onAppear{
                self.transferFundsVM.populateAccounts()
            }
            
            Button("Submit Transfer"){
                
            }.padding()
            .actionSheet(isPresented: $showSheet){
                ActionSheet(title: Text("Transfer Funds"), message: Text("Choose an account"), buttons: self.actionSheetButtons)
            }
        }.navigationBarTitle("Transfer Funds").embedInNavigationView()
    }
}

struct TransferFundsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TransferFundsScreen()
    }
}

struct TransferFundsAccountSelectionButtons: View{
    
    @ObservedObject var transferFundsVM: TransferFundsViewModel
    @Binding var showSheet: Bool
    @Binding var isFromAccount: Bool
    @Binding var isToAccount: Bool
    
    var body: some View{
        VStack(spacing: 10){
            Button("From \(self.transferFundsVM.fromAccountName) \(self.transferFundsVM.fromAccountType)"){
                showSheet = true
                isFromAccount = true
                isToAccount = false
                
            }.padding().frame(maxWidth: .infinity)
                .background(.green)
                .foregroundColor(.white)
                .bold()
                .cornerRadius(16)
            
            Button("To \(self.transferFundsVM.toAccountName) \(self.transferFundsVM.toAccountType)"){
                showSheet = true
                isFromAccount = false
                isToAccount = true
            }.padding().frame(maxWidth: .infinity)
                .background(.green)
                .foregroundColor(.white)
                .bold()
                .cornerRadius(16)
                .opacity(self.transferFundsVM.fromAccount != nil ? 1.0 : 0.5)
                .disabled(self.transferFundsVM.fromAccount == nil)
            TextField("Amount", text: $transferFundsVM.amount).textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Narration", text: $transferFundsVM.narration).textFieldStyle(RoundedBorderTextFieldStyle())
                
        }.padding()
    }
}
