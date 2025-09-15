//
//  ExLable.swift
//  Blu-Bank
//
//  Created by Nik on 14/09/2025.
//

import UIKit

extension UILabel {

    func setFont(font: UIFont) -> UILabel {
        self.font = font
        return self
    }

    func setTitle(string: String) -> UILabel {
        self.text = string
        return self
    }

    func setAttributed( _ str: NSAttributedString) -> UILabel {
        self.attributedText = str
        return self
    }

    func setScaleFont(size: CGFloat) -> UILabel {
        self.minimumScaleFactor = size
        self.adjustsFontSizeToFitWidth = true
        return self
    }

    func setColor(hex: String) -> UILabel {
        textColor = UIColor.fromHex(hex: hex)
        return self
    }

    func setColor(color: UIColor) -> UILabel {
        textColor = color
        return self
    }

    func setNumberLine(line: Int) -> UILabel {
        numberOfLines = line
        return self
    }

    func setAligment(align: NSTextAlignment) -> UILabel {
        self.textAlignment = align
        return self
    }

    func underline() {
         if let textString = self.text {
             let attributedString = NSMutableAttributedString(string: textString)
             attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                           value: NSUnderlineStyle.single.rawValue,
                                           range: NSRange(location: 0, length: textString.count))
             self.attributedText = attributedString
             self.isUserInteractionEnabled = true

         }
     }

    func setAttributedText(fullString: String, mainFont: UIFont, boldString: String, boldFont: UIFont) -> UILabel {
        self.attributedText =  fullString.attributedText(mainFont: mainFont, boldString: boldString, boldFont: boldFont)
        return self
    }

    func sizeToFitText() -> UILabel {
           self.sizeToFit()
        return self
       }
}
