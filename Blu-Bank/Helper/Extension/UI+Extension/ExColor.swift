//
//  ExColor.swift
//  Blu-Bank
//
//  Created by Nik on 14/09/2025.
//

import UIKit
import SwiftUI

// MARK: - UIColor Hex Extension
public extension UIColor {
    @objc static func fromHex(hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if (cString.count) != 6 {
            return UIColor.gray
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

// MARK: - SwiftUI Color Hex Extension
extension Color {
    static func fromHex(_ hex: String) -> Color {
        Color(UIColor.fromHex(hex: hex))
    }
}
