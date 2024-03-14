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
    let width: CGFloat// = 220
    
    var body: some View {
        Button(action: action) {
                       Text(buttonTitle)
                           .foregroundColor(.white)
                           .padding()
                           .frame(width: width, height: 50)
                           .background(Color.teal.gradient)
                           .cornerRadius(10.0)
                           //.backgroundStyle(.teal.gradient)
                   }
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(action: {}, buttonTitle: "Button", width: 220)
    }
}
