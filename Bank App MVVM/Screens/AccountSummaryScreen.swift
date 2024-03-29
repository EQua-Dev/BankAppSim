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
    case accountDetail
}

struct AccountSummaryScreen: View {
    @Binding var currentScreen: Screens

    
    @ObservedObject private var accountSummaryVM = AccountSummaryViewModel()
    @State private var isPresented: Bool = false
    @State private var activeSheet: ActiveSheet = .addAccount
    
    @Binding var selectedAccount: AccountViewModel //= AccountViewModel(account: AccountInfo())
    
    var body: some View {
        VStack{
            GeometryReader{ geometry in
                VStack{
                    
                    Text(String.generateGreeting())
                        .font(.system(size: 32))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    
                    Text("My Accounts")
                        .font(.system(size: 32))
                        .fontWeight(.semibold)
                        .foregroundStyle(.teal.gradient)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        
                    AccountListView(accounts: self.accountSummaryVM.accounts, onTapAccount: {account in
                        //self.selectedAccount = account
                        //navigate to new screen
                        currentScreen = .accountDetail
                        selectedAccount = account
                    }).frame(height: geometry.size.height/2)
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
        /*.sheet(isPresented: $isPresented, onDismiss: {
            //get all accounts
            self.accountSummaryVM.getAllMyAccounts()
        }){
            switch(self.activeSheet){
                case .addAccount:
                    CreateAccountScreen()
                case .transferFunds:
                    TransferFundsScreen( account: selectedAccount.account)
                case .accountDetail:
                    AccountDetailScreen(currentScreen: )
            }
            
        }*/
        .navigationBarItems(trailing: Button("Add Account"){
            activeSheet = .addAccount
            self.isPresented = true
        })
        .navigationBarTitle("Hello \(String.userName()!)")
        .embedInNavigationView()
    }
    
}

struct AccountSummaryScreen_Previews: PreviewProvider {
    static var previews: some View {
        let currentScreen = Binding.constant(Screens.accountsHome)
        AccountSummaryScreen(currentScreen: currentScreen, selectedAccount: Binding.constant(AccountViewModel(account: AccountInfo())))
    }
}
