//
//  AccountListView.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 05/02/2024.
//

import SwiftUI

struct AccountListView: View {
    
    let accounts: [AccountViewModel]
    let onTapAccount: (AccountViewModel) -> Void
    
    var body: some View {
        List(accounts, id: \.accountId){ account in
            AccountCell(account: account).onTapGesture {
                onTapAccount(account)
            }
            
        }
    }
}

struct AccountListView_Previews: PreviewProvider {
    static var previews: some View {
        
        let account = AccountInfo()
        
        let accountVM = AccountViewModel(account: account)
        
        AccountListView(accounts: [accountVM], onTapAccount: {_ in })
    }
}

struct AccountCell: View {
    let account : AccountViewModel
    var body: some View {
        
        let dateCreated: Int64 = Int64(account.accountDateCreated)!
        HStack{
            VStack(alignment: .leading, spacing: 10){
                Text(account.accountNumber)
                    .font(.headline)
                Text(account.accountType)
                    .opacity(0.5)
                    .font(.caption)
                
                /*Text("created \(String.formatDate(milliseconds: dateCreated, format: "EEE, dd MMM, yyyy"))")
                    .opacity(0.5)
                    .font(.caption)*/
            }
            Spacer()
            Text("\(account.accountBalance.formatAsCurrency())")
                .foregroundColor(.green)
        }
    }
}
