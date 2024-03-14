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
    
    @State private var isPresented: Bool = false
    @State private var activeSheet: ActiveSheet = .addAccount
    
    var body: some View {
        
        VStack{
            GeometryReader{ geometry in
                VStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text("\(accountDetail.accountBalance.formatAsCurrency())")
                                .foregroundColor(.white)
                                .font(.system(size: 32))
                                .padding()
                            Text(accountDetail.accountNumber).font(.subheadline).fontWeight(.black).padding()
                        }
                        
                        Spacer()
                        VStack(alignment: .trailing){
                            Image(systemName: "doc.on.doc").font(.subheadline)
                        }.padding()
                    }.background(Color.teal.gradient)
                        .frame(width: geometry.size.width, height: geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom) //.shadow(color: .teal, radius: 10)
                    
                    Text(accountDetail.accountOwner.userName)
                }.padding(.all)
            }
        }
        /*.onAppear{
         self.accountSummaryVM.getAllMyAccounts()
         }*/
        .sheet(isPresented: $isPresented, onDismiss: {
            //get all accounts
            //self.accountSummaryVM.getAllMyAccounts()
        }){
            TransferFundsScreen( account: accountDetail.account)
        }
        .navigationBarItems(leading: Button("Back"){
            currentScreen = .accountsHome
        }, trailing: Button("Transfer"){
            self.isPresented = true
        })
    //.navigationBarTitle("Hello \(String.userName()!)")
        .embedInNavigationView()
}
}

struct AccountDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        let currentScreen = Binding.constant(Screens.accountDetail)
        AccountDetailScreen(currentScreen: currentScreen, accountDetail: AccountViewModel(account: AccountInfo()))
    }
}
