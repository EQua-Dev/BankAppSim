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
            AccountCell(account: account)
            
        }
    }
}

struct AccountListView_Previews: PreviewProvider {
    static var previews: some View {
        
        let account = AccountInfo()
        
        let accountVM = AccountViewModel(account: account)
        
        AccountListView(accounts: [accountVM])
    }
}

struct AccountCell: View {
    let account : AccountViewModel
    var body: some View {
        
        var dateCreated: Int64 = Int64(account.accountDateCreated)!
        HStack{
            VStack(alignment: .leading, spacing: 10){
                Text(account.accountType)
                    .font(.headline)
                
                Text("created \(String.formatDate(milliseconds: dateCreated, format: "EEE, dd MMM, yyyy"))")
                    .opacity(0.5)
                    .font(.caption)
            }
            Spacer()
            Text("\(account.accountBalance.formatAsCurrency())")
                .foregroundColor(.green)
        }
    }
}
