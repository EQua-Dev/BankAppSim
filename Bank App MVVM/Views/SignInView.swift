//
//  SignInView.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 12/03/2024.
//

import SwiftUI

struct SignInView: View {
    
    @Binding var currentScreen: Screens

    
    @ObservedObject private var createUserVM = CreateUserViewModel()
    @State private var navigateToHome = false

    
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                Spacer()
                TextField("Username", text: self.$createUserVM.username)
                              .padding()
                              .background(Color.gray.opacity(0.1))
                              .cornerRadius(5.0)
                              .padding(.horizontal, 15)
                          
                SecureField("Password", text: self.$createUserVM.password)
                              .padding()
                              .background(Color.gray.opacity(0.1))
                              .cornerRadius(5.0)
                              .padding(.horizontal, 15)
                Spacer()
                CustomButton(action: {
                    createUserVM
                        .signInUser{success in
                            if success{
                                currentScreen = .accountsHome
                                print(success)
                            }else{
                                
                            }
                            
                        }
                }, buttonTitle: "Login", width: 220)
               
                           .alert(isPresented: $createUserVM.showAlert) {
                               Alert(title: Text("Error"), message: Text("\(createUserVM.errorMessage)"), dismissButton: .default(Text("OK")))
                           }
                           
                           // You can add more UI elements here like a "Forgot Password" button or a loading indicator.
                           
                           Spacer()
                
                Button("Create New User Account"){
                    currentScreen = .signUp
                }.foregroundStyle(.teal.gradient)
                Spacer()
            }
            .padding()
            if createUserVM.isLoading{
                LoadingIndicatorView(loadingMessage: "Logging In")
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
            
        }
        .navigationBarTitle("Sign In")
            .embedInNavigationView()
        
    }
}

/*private func signIn(createUserVM: CreateUserViewModel, currentScreen: Screens){
    createUserVM
        .signInUser{success in
            if success{
                currentScreen = .accountsHome
                print(success)
            }else{
                
            }
            
        }
}*/

struct SignInView_Previews: PreviewProvider {
    
    static var previews: some View {
        let currentScreen = Binding.constant(Screens.signUp)
        SignInView(currentScreen: currentScreen)
    }
}
