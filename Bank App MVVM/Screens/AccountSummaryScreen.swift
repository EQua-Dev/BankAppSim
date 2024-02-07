//
//  AccountSummaryScreen.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 04/02/2024.
//

import SwiftUI

struct AccountSummaryScreen: View {
    
    @ObservedObject private var accountSummaryVM = AccountSummaryViewModel()
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack{
            GeometryReader{ geometry in
                VStack{
                    AccountListView(accounts: self.accountSummaryVM.accounts).frame(height: geometry.size.height/2)
                    AccountsTotalView(accountsTotal: self.accountSummaryVM.total).padding(16)
                    Spacer() //was not necessary for me
                }
            }
        }
        .onAppear{
            self.accountSummaryVM.getAllAccounts()
        }
        .sheet(isPresented: $isPresented, onDismiss: {
            //get all accounts
            self.accountSummaryVM.getAllAccounts()
        }){
            CreateAccountScreen()
        }
        .navigationBarItems(trailing: Button("Add Account"){
            self.isPresented = true
        })
        .navigationBarTitle("Accounts Summary")
        .embedInNavigationView()
    }
    
}

struct AccountSummaryScreen_Previews: PreviewProvider {
    static var previews: some View {
        AccountSummaryScreen()
    }
}
