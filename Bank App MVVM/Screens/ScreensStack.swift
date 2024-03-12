//
//  ScreensStack.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 12/03/2024.
//

import Foundation
import SwiftUI

enum Screens: CaseIterable{
    
    case signUp
    case signIn
    case accountsHome
}

    //create an extension of the Screens enum that conditionally sets the value
extension Screens{
    var title: some View {
        switch self {
            case .signUp:
                return AnyView(SignUpView(currentScreen: Binding.constant(.signUp)))
            case .signIn:
                return AnyView(SignInView(currentScreen: Binding.constant(.signIn)))
            case .accountsHome:
                return AnyView(AccountSummaryScreen(currentScreen: Binding.constant(.accountsHome)))
        }
    }
}
