//
//  AccountSummaryScreen.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 04/02/2024.
//

import SwiftUI

struct AccountSummaryScreen: View {
    
    @ObservedObject private var accountSummaryVM = AccountSummaryViewModel()
    
    var body: some View {
        VStack{
            AccountListView(accounts: accountSummaryVM.accounts)
            AccountsTotalView(accountsTotal: accountSummaryVM.total)
        }
            .onAppear{
                self.accountSummaryVM.getAllAccounts()
            }
    }
    
}

struct AccountSummaryScreen_Previews: PreviewProvider {
    static var previews: some View {
        AccountSummaryScreen()
    }
}
