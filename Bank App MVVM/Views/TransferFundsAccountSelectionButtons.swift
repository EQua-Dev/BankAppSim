//
//  TransferFundsView.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 09/02/2024.
//

import SwiftUI

struct TransferFundsAccountSelectionButtons: View{
    
    @ObservedObject var transferFundsVM: TransferFundsViewModel
    @Binding var showSheet: Bool
    @Binding var isFromAccount: Bool
    @Binding var isToAccount: Bool
    
    var body: some View{
        VStack(spacing: 10){
            /* Button("From \(self.transferFundsVM.fromAccountName) \(self.transferFundsVM.fromAccountType)"){
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
             */
        }.padding()
    }
}
