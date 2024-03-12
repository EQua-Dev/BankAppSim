//
//  LoadingIndicatorView.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 12/03/2024.
//

import SwiftUI

struct LoadingIndicatorView: View {
    let loadingMessage: String
    var body: some View {
        ProgressView(loadingMessage)
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                    }
}

struct LoadingIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicatorView(loadingMessage: "Please wait")
    }
}
