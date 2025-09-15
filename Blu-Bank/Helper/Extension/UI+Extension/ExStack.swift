//
//  ExStack.swift
//  Blu-Bank
//
//  Created by Nik on 14/09/2025.
//

import UIKit

extension UIStackView {
    
    func stack(space: CGFloat) -> UIStackView {
        self.spacing = space
        return self
    }
    
    func stack(axis: NSLayoutConstraint.Axis ,
               alignment: UIStackView.Alignment ,
               distribution: UIStackView.Distribution ,
               space: CGFloat = 0) -> UIStackView {
        
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = space
        return self
    }
    
    func addArrange(views: UIView...) -> UIStackView {
        for viwe in views {
            self.addArrangedSubview(viwe)
        }
        return self
    }
}
