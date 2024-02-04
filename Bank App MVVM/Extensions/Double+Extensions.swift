//
//  Double+Extension.swift
//  Bank App MVVM
//
//  Created by Richard Uzor on 03/02/2024.
//

import Foundation

extension Double {
    
    func formatAsCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let formattedCurrency = formatter.string(from: self as NSNumber)
        return formattedCurrency ?? ""
    }
    
}
