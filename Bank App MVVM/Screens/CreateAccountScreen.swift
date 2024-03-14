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
        GeometryReader{ geometry in
            VStack{
                Text("Create Account").font(.title).bold().padding()
                Form{
                    Section("Select Account Type"){
                        Picker(selection: self.$createAccountVM.accountType, label: EmptyView()){
                            ForEach(AccountType.allCases, id: \.self){
                                accountType in
                                Text(accountType.title).tag(accountType)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    Section("Enter Initial Deposit (Min ₦50.00)"){
                        TextField("Initial Deposit", text: self.$createAccountVM.initialDeposit)
                        
                    }
                }
                .alert(isPresented: $createAccountVM.showAlert) {
                    Alert(title: Text("Error"), message: Text("\(createAccountVM.errorMessage)"), dismissButton: .default(Text("OK")))
                }
                CustomButton(action: {
                    self.createAccountVM.createAccount{ success in
                        if success {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }, buttonTitle: "Create Account", width: 220)
                
            }.padding()
            if createAccountVM.isLoading{
                LoadingIndicatorView(loadingMessage: "Creating Account")
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

struct CreateAccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountScreen()
    }
}
