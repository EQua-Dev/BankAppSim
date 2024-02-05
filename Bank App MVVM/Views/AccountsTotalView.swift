//
//  AccountsTotalView.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 05/02/2024.
//

import SwiftUI

struct AccountsTotalView: View {
    let accountsTotal: Double
    var body: some View {
        HStack{
            Text("Total: ").font(.largeTitle)
            Spacer()

            Text("\(accountsTotal.formatAsCurrency())").font(.largeTitle).bold()

        }
    }
}

struct AccountsTotalView_Previews: PreviewProvider {
    static var previews: some View {
        AccountsTotalView(accountsTotal: 400)
    }
}
