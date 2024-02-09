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
        
        ScrollView{
            VStack{
                AccountListView(accounts: self.transferFundsVM.accounts).frame(height: 200)
                TransferFundsAccountSelectionButtons(transferFundsVM: self.transferFundsVM, showSheet: $showSheet, isFromAccount: $isFromAccount, isToAccount: $isToAccount).frame(height: 300)
                Spacer()
                .onAppear{
                    self.transferFundsVM.populateAccounts()
                }
                //show error message from the transaction if any
                Text(self.transferFundsVM.message ?? "")
                
                Button("Submit Transfer"){
                    self.transferFundsVM.submitTransfer(){
                        //dismiss the modal
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }.padding()
                .actionSheet(isPresented: $showSheet){
                    ActionSheet(title: Text("Transfer Funds"), message: Text("Choose an account"), buttons: self.actionSheetButtons)
                }
            }
        }
       .navigationBarTitle("Transfer Funds").embedInNavigationView()
    }
}

struct TransferFundsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TransferFundsScreen()
    }
}


