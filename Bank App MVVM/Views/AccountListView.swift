//
//  AccountListView.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 05/02/2024.
//

import SwiftUI

struct AccountListView: View {
    
    let accounts: [AccountViewModel]
    
    var body: some View {
        List(accounts, id: \.accountId){ account in
            HStack{
                VStack(alignment: .leading, spacing: 10){
                    Text(account.name)
                        .font(.headline)
                    
                    Text(account.accountType)
                        .opacity(0.5)
                }
                Spacer()
                Text("\(account.balance.formatAsCurrency())")
                    .foregroundColor(.green)
            }
            
        }
    }
}

struct AccountListView_Previews: PreviewProvider {
    static var previews: some View {
        
        let account = Account(id: "123", name: "Emeka Ike", accountType:  .checking, balance: 200)
        
        let accountVM = AccountViewModel(account: account)
        
        AccountListView(accounts: [accountVM])
    }
}
