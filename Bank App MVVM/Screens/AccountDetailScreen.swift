//
//  AccountDetailScreen.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 14/03/2024.
//

import SwiftUI

struct AccountDetailScreen: View {
    @Binding var currentScreen: Screens
    
    let accountDetail: AccountViewModel
    
    var body: some View {
        
        VStack{
            
            Text(accountDetail.accountOwner.userName)
            Text("\(accountDetail.accountBalance.formatAsCurrency())")
                .foregroundColor(.green)
        } .navigationBarItems(leading: Button("Back"){
            currentScreen = .accountsHome
        })
        .navigationBarTitle("Hello \(String.userName()!)")
        .embedInNavigationView()
    }
}

struct AccountDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        let currentScreen = Binding.constant(Screens.accountDetail)
        AccountDetailScreen(currentScreen: currentScreen, accountDetail: AccountViewModel(account: AccountInfo()))
    }
}
