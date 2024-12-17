//
//  Double+Additions.swift

import Foundation

extension Double {
    func string(style: NumberFormatter.Style = .decimal,
                maximumFractionDigits: Int = 0,
                usesSeparator: Bool = false,
                decimalSeparator: String = ",") -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = style
        numberFormatter.usesGroupingSeparator = usesSeparator
        numberFormatter.minimumFractionDigits = 1
        numberFormatter.maximumFractionDigits = maximumFractionDigits
        numberFormatter.decimalSeparator = decimalSeparator
        numberFormatter.groupingSeparator = " " // Use a space as the grouping separator
        numberFormatter.groupingSize = 3
        
        if let formattedString = numberFormatter.string(from: NSNumber(value: self)) {
           return formattedString // Output: "2 500,00"
        } else {
            return ""
        }
    }
}
