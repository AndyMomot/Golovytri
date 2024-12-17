//
//  String+Additions.swift

import Foundation

extension String {
    func toDate(format: Date.Format) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.date(from: self)
    }
    
    func toNumberFormat(with style: NumberFormatter.Style = .decimal,
                        separator: String = " ",
                        groupingSize: Int = 3,
                        numberType: NumberType = .int,
                        maximumFractionDigits: Int = 2) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = style
        numberFormatter.groupingSeparator = separator
        numberFormatter.groupingSize = groupingSize
        numberFormatter.maximumFractionDigits = maximumFractionDigits
        
        var nsNumber: NSNumber {
            switch numberType {
            case .int:
                return NSNumber(value: Int(self) ?? 0)
            case .double:
                return NSNumber(value: Double(self) ?? 0)
            case .float:
                return NSNumber(value: Float(self) ?? 0)
            }
        }
        
        if let formattedNumber = numberFormatter.string(from: nsNumber) {
            return formattedNumber
        } else {
            return self
        }
    }
}

extension String {
    enum NumberType {
        case int, double, float
    }
}
