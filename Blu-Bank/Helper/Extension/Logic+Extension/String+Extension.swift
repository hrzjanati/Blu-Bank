//
//  String+Extension.swift
//  Blu-Bank
//
//  Created by Nik on 14/09/2025.
//

import UIKit

extension String {
    // MARK: - ----------------- attributedText
    func attributedText(mainFont: UIFont, boldString: String, boldFont: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: mainFont])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont]
        let range = (self as NSString).range(of: boldString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString
    }
}
