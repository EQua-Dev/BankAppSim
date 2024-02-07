//
//  CreateAccountScreen.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 07/02/2024.
//

import SwiftUI

struct CreateAccountScreen: View {
    
    //for the sake of dismissing the modal
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var createAccountVM = CreateAccountViewModel()
    
    var body: some View {
        Form{
            TextField("Name", text: self.$createAccountVM.name)
            Picker(selection: self.$createAccountVM.accountType, label: EmptyView()){
                ForEach(AccountType.allCases, id: \.self){
                    accountType in
                    Text(accountType.title).tag(accountType)
                }
            }.pickerStyle(SegmentedPickerStyle())
            TextField("Balance", text: self.$createAccountVM.balance)
            
            HStack{
                Spacer()
                Button("Submit"){
                    self.createAccountVM.createAccount{ success in
                        if success {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        
                    }
                }
                Spacer()
            }
            
        }
        
    }
}

struct CreateAccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountScreen()
    }
}
