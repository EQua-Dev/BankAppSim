//
//  CustomButton.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 12/03/2024.
//

import SwiftUI

struct CustomButton: View {
    let action: () -> Void
    let buttonTitle: String
    
    var body: some View {
        Button(action: action) {
                       Text(buttonTitle)
                           .foregroundColor(.white)
                           .padding()
                           .frame(width: 220, height: 50)
                           .background(Color.blue)
                           .cornerRadius(10.0)
                   }
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(action: {}, buttonTitle: "Button")
    }
}
