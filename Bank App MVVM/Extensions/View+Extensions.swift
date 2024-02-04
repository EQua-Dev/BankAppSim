//
//  View+Extensions.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 03/02/2024.
//

import Foundation
import SwiftUI

extension View {
    
    func embedInNavigationView() -> some View {
        NavigationView { self }
    }
    
    
}
