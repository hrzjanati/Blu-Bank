//
//  ExView.swift
//  Blu-Bank
//
//  Created by Nik on 14/09/2025.
//

import UIKit

enum Corner{
    case topRight
    case topLeft
    case bottomRight
    case bottomLeft
}
// MARK: - ----------------- All
extension UIView {
    
    // if you use builder pattern you can close your FP
    func closed() {}
    
    func add(base: UIView) -> UIView {
        base.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        return self
    }
    
    func translatesAutoresizingMaskIntoConstraint(_ bool: Bool? = nil) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = bool ?? false
        return self
    }
    
    func setCorner(radius: CGFloat) -> UIView {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        return self
    }
    
    func setBackground(color: UIColor) -> UIView {
        backgroundColor = color
        return self
    }
    
    func setBackground(hex: String) -> UIView {
        backgroundColor = UIColor.fromHex(hex: hex)
        return self
    }
    
    func setHidden(isHidden: Bool) -> UIView {
        self.isHidden = isHidden
        return self
    }
    
    func setBorder(width: CGFloat = 1, color: UIColor) -> UIView {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        
        return self
    }
    
    func addShadow(color: UIColor = .black, opacity: Float = 0.12, radius: CGFloat = 2, offset: CGSize = .zero) -> UIView {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        // Set the masksToBounds property to false so that the shadow is not clipped
        layer.masksToBounds = false
        return self
        
    }
    
    func differentRound(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) -> UIView {
        let minX = bounds.minX
        let minY = bounds.minY
        let maxX = bounds.maxX
        let maxY = bounds.maxY
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: minX + topLeft, y: minY))
        path.addLine(to: CGPoint(x: maxX - topRight, y: minY))
        path.addArc(withCenter: CGPoint(x: maxX - topRight, y: minY + topRight), radius: topRight, startAngle: CGFloat(3 * Double.pi / 2), endAngle: 0, clockwise: true)
        path.addLine(to: CGPoint(x: maxX, y: maxY - bottomRight))
        path.addArc(withCenter: CGPoint(x: maxX - bottomRight, y: maxY - bottomRight), radius: bottomRight, startAngle: 0, endAngle: CGFloat(Double.pi / 2), clockwise: true)
        path.addLine(to: CGPoint(x: minX + bottomLeft, y: maxY))
        path.addArc(withCenter: CGPoint(x: minX + bottomLeft, y: maxY - bottomLeft), radius: bottomLeft, startAngle: CGFloat(Double.pi / 2), endAngle: CGFloat(Double.pi), clockwise: true)
        path.addLine(to: CGPoint(x: minX, y: minY + topLeft))
        path.addArc(withCenter: CGPoint(x: minX + topLeft, y: minY + topLeft), radius: topLeft, startAngle: CGFloat(Double.pi), endAngle: CGFloat(3 * Double.pi / 2), clockwise: true)
        path.close()
        self.translatesAutoresizingMaskIntoConstraints = false
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        return self
    }
    
    func setClipToBaounds(_ bool: Bool? = nil) -> UIView {
        clipsToBounds = bool ?? false
        return self
    }
    
    func styleButton(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: CGColor) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
    }
    /**
     This function is for rounding desired corners of a certain view.
     - parameter corners: corners that we want to make round.
     - parameter radius: The intensity of corners.
     */
    func roundSomeCorners(corners: [Corner], radius: CGFloat) {
        var maskedCorners = CACornerMask()
        for corner in corners{
            switch corner {
            case .topRight:
                maskedCorners.insert(.layerMaxXMinYCorner)
            case .topLeft:
                maskedCorners.insert(.layerMinXMinYCorner)
            case .bottomRight:
                maskedCorners.insert(.layerMaxXMaxYCorner)
            case .bottomLeft:
                maskedCorners.insert(.layerMinXMaxYCorner)
            }
        }
        layer.cornerRadius = radius
        layer.maskedCorners = maskedCorners
    }
}
// MARK: - ----------------- Safe Area Anchor
extension UIView {
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        }
        return topAnchor
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return safeAreaLayoutGuide.leftAnchor
        }
        return leftAnchor
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return safeAreaLayoutGuide.rightAnchor
        }
        return rightAnchor
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        }
        return bottomAnchor
    }
}

extension UIView {
    func noCorners() {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: 0, height: 0))
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        layer.mask = shape
    }
    
    func applyCorners(to: UIRectCorner, with rect: CGRect) {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: to,
                                cornerRadii: CGSize(width: 16, height: 16))
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        layer.mask = shape
    }
}
// MARK: - ----------------- top righte and left corner
extension UIView {
    /// Applies rounded corners to the top-left and top-right corners of the view.
    /// - Parameter radius: The radius of the rounded corners.
    func roundTopCorners(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top-left and top-right corners
        self.layer.masksToBounds = true
    }
}
