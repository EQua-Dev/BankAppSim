//
//  SignInView.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 12/03/2024.
//

import SwiftUI

struct SignInView: View {
    
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
                Button(action: {
                    createUserVM
                        .signInUser{success in
                            if success{
                                navigateToHome = true
                                print(success)
                            }else{
                                
                            }
                            
                        }
                           }) {
                               Text("Login")
                                   .foregroundColor(.white)
                                   .padding()
                                   .frame(width: 220, height: 50)
                                   .background(Color.blue)
                                   .cornerRadius(10.0)
                           }
                           .alert(isPresented: $createUserVM.showAlert) {
                               Alert(title: Text("Error"), message: Text("\(createUserVM.errorMessage)"), dismissButton: .default(Text("OK")))
                           }
                           
                           // You can add more UI elements here like a "Forgot Password" button or a loading indicator.
                           
                           Spacer()
                
                NavigationLink("Create New User Account", destination: {SignUpView()})
                Spacer()
            }
            .padding()
            if createUserVM.isLoading{
                LoadingIndicatorView(loadingMessage: "Logging In")
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
            
            NavigationLink(destination: AccountSummaryScreen(), isActive: $navigateToHome){
                    EmptyView()
                }
        }
        .navigationBarTitle("Sign In")
            .embedInNavigationView()
        
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
