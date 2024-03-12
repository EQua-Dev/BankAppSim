//
//  Bank_App_MVVMApp.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 03/02/2024.
//

import SwiftUI

@main
struct Bank_App_MVVMApp: App {
    @State private var currentScreen: Screens = .signIn // Set default screen to SignInView
    
    var body: some Scene {
        WindowGroup {
            // Use a switch statement to determine which view to display based on the currentScreen
            switch currentScreen {
                case .signUp:
                    SignUpView(currentScreen: $currentScreen)
                case .signIn:
                    SignInView(currentScreen: $currentScreen)
                case .accountsHome:
                    AccountSummaryScreen(currentScreen: $currentScreen)
            }        }
    }
}
