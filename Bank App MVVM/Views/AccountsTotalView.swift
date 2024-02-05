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
        Text("\(accountsTotal.formatAsCurrency())")
    }
}

struct AccountsTotalView_Previews: PreviewProvider {
    static var previews: some View {
        AccountsTotalView(accountsTotal: 400)
    }
}
