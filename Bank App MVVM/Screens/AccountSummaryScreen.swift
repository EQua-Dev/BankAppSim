//
//  AccountSummaryScreen.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 04/02/2024.
//

import SwiftUI

enum ActiveSheet{
    case addAccount
    case transferFunds
}

struct AccountSummaryScreen: View {
    @Binding var currentScreen: Screens

    
    @ObservedObject private var accountSummaryVM = AccountSummaryViewModel()
    @State private var isPresented: Bool = false
    @State private var activeSheet: ActiveSheet = .addAccount
    
    var body: some View {
        VStack{
            GeometryReader{ geometry in
                VStack{
                    AccountListView(accounts: self.accountSummaryVM.accounts).frame(height: geometry.size.height/2)
                    AccountsTotalView(accountsTotal: self.accountSummaryVM.total).padding(16)
                    Spacer() //was not necessary for me
                    Button("Transfer Funds"){
                        self.activeSheet = .transferFunds
                        self.isPresented = true
                    }.padding()
                }
            }
        }
        .onAppear{
            self.accountSummaryVM.getAllMyAccounts()
        }
        .sheet(isPresented: $isPresented, onDismiss: {
            //get all accounts
            self.accountSummaryVM.getAllMyAccounts()
        }){
            switch(self.activeSheet){
                case .addAccount:
                    CreateAccountScreen()
                case .transferFunds:
                    TransferFundsScreen()
            }
            
        }
        .navigationBarItems(trailing: Button("Add Account"){
            activeSheet = .addAccount
            self.isPresented = true
        })
        .navigationBarTitle("Accounts Summary")
        .embedInNavigationView()
    }
    
}

struct AccountSummaryScreen_Previews: PreviewProvider {
    static var previews: some View {
        let currentScreen = Binding.constant(Screens.accountsHome)
        AccountSummaryScreen(currentScreen: currentScreen)
    }
}
