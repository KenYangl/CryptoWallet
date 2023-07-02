//
//  String+Localized.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/25.
//

import UIKit
import Foundation
import SwiftUI

extension LocalizedStringKey {
    
}

extension Array where Element == String {
    static var INVALID_STRING_PERCENT_FORMATS = [
        "\\@\\%[^\\%1-9\\@]", // Incorrect percentage formats
        "\\%([1-9][\\$])?s"
    ]
}

extension String {
    public var localized: String {
//        if let languageString = getLocalizedString() {
//            return languageString.replacingOccurrences(of: "\\n", with: "\n")
//        }
        return NSLocalizedString(self, comment: "")
    }
    
    public func localized(with arguments: String...) -> String {
        return String(format: self.cleansedLocalizedFormat, arguments: arguments)
    }
    
    public func localized(with arguments: [String]) -> String {
        guard !arguments.isEmpty else { return localized }
        return String(format: self.cleansedLocalizedFormat, arguments: arguments)
    }
    
    private var cleansedLocalizedFormat: String {
        let formatString = self.localized

        for pattern in [String].INVALID_STRING_PERCENT_FORMATS {
            let regex = try? NSRegularExpression(pattern: pattern)
            let invalidMatch = regex?.firstMatch(in: formatString, range: .init(location: 0, length: formatString.count))

            guard invalidMatch == nil else {
                return "INVALID_CONTENT"
            }
        }
        return formatString
    }
}
