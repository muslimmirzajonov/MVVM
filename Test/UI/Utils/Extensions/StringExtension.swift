//
//  StringExtension.swift
//  DashBoardManagment
//
//  Created by muslim mirzajonov on 05/05/22.
//

import Foundation
import UIKit
extension String{
    func formatDate(outputFormat:String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = outputFormat

        let date: Date? = dateFormatterGet.date(from: self)
        return dateFormatterPrint.string(from: date ?? Date())
    }
}

extension NSMutableAttributedString {

    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)

        // Swift 4.2 and above
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)

        // Swift 4.1 and below
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
}
