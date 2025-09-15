//
//  ExContaner.swift
//  Blu-Bank
//
//  Created by Nik on 14/09/2025.
//

import UIKit

extension UIView {

    func horizontal(to: UIView, constant: CGFloat = 0) -> UIView {

        self.leftAnchor
            .constraint(equalTo: to.leftAnchor, constant: constant)
            .isActive = true

        self.rightAnchor
            .constraint(equalTo: to.rightAnchor, constant: -constant)
            .isActive = true

        return self
    }

    func vertical(to: UIView, constant: CGFloat = 0) -> UIView {

        self.topAnchor
            .constraint(equalTo: to.topAnchor, constant: constant)
            .isActive = true

        self.bottomAnchor
            .constraint(equalTo: to.bottomAnchor, constant: -constant)
            .isActive = true

        return self
    }

    func left(to: NSLayoutAnchor<NSLayoutXAxisAnchor>,
              constant: CGFloat = 0) -> UIView {

        self.leftAnchor
            .constraint(equalTo: to, constant: constant)
            .isActive = true
        return self
    }

    func right(to: NSLayoutAnchor<NSLayoutXAxisAnchor>,
               constant: CGFloat = 0) -> UIView {

        self.rightAnchor
            .constraint(equalTo: to, constant: -constant)
            .isActive = true

        return self
    }

    func leading(to: NSLayoutAnchor<NSLayoutXAxisAnchor>,
                 constant: CGFloat = 0) -> UIView {

        self.leadingAnchor
            .constraint(equalTo: to, constant: constant)
            .isActive = true
        return self
    }
    
    func leadinggreaterThanOrEqualTo(to: NSLayoutAnchor<NSLayoutXAxisAnchor>,
                 constant: CGFloat = 0) -> UIView {

        self.leadingAnchor
            .constraint(greaterThanOrEqualTo: to, constant: constant)
            .isActive = true
        return self
    }

    func trailing(to: NSLayoutAnchor<NSLayoutXAxisAnchor>,
                  constant: CGFloat = 0) -> UIView {

        self.trailingAnchor
            .constraint(equalTo: to, constant: -constant)
            .isActive = true

        return self
    }
    
    func trailingGreaterThanOrEqualTo(to: NSLayoutAnchor<NSLayoutXAxisAnchor>,
                  constant: CGFloat = 0) -> UIView {

        self.trailingAnchor
            .constraint(greaterThanOrEqualTo: to, constant: -constant)
            .isActive = true

        return self
    }

    func top(to: NSLayoutAnchor<NSLayoutYAxisAnchor>,
             constant: CGFloat = 0) -> UIView {

        self.topAnchor
            .constraint(equalTo: to, constant: constant)
            .isActive = true

        return self
    }

    func bottom(to: NSLayoutAnchor<NSLayoutYAxisAnchor>,
                constant: CGFloat = 0) -> UIView {

        self.bottomAnchor
            .constraint(equalTo: to, constant: -constant)
            .isActive = true

        return self
    }
    
    func bottomGreater(to: NSLayoutAnchor<NSLayoutYAxisAnchor>,
                constant: CGFloat = 0) -> UIView {

        self.bottomAnchor
            .constraint(greaterThanOrEqualTo: to, constant: -constant)
            .isActive = true

        return self
    }

    func centerX(to: NSLayoutAnchor<NSLayoutXAxisAnchor>,
                 constant: CGFloat = 0) -> UIView {

        self.centerXAnchor
            .constraint(equalTo: to, constant: constant)
            .isActive = true

        return self
    }

    func centerY(to: NSLayoutAnchor<NSLayoutYAxisAnchor>,
                 constant: CGFloat = 0) -> UIView {

        self.centerYAnchor
            .constraint(equalTo: to, constant: constant)
            .isActive = true

        return self
    }

    func center(to: UIView) -> UIView {

        self.centerYAnchor
            .constraint(equalTo: to.centerYAnchor)
            .isActive = true

        self.centerXAnchor
            .constraint(equalTo: to.centerXAnchor)
            .isActive = true

        return self

    }

    func all(view: UIView) -> UIView {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.rightAnchor.constraint(equalTo: view.rightAnchor),
            self.leftAnchor.constraint(equalTo: view.leftAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        return self
    }

    func all(view: UIView, constant: CGFloat) -> UIView {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: constant),
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -constant),
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: constant),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant)
        ])

        return self
    }

    func height(constant: CGFloat) -> UIView {
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }

    func width(constant: CGFloat) -> UIView {
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }

    func width(to: UIView, constant: CGFloat = 0) -> UIView {
        self.widthAnchor.constraint(equalTo: to.widthAnchor, constant: constant).isActive = true

        return self
    }

    func proportionalWidth(to: UIView, multiplier: CGFloat = 0) -> UIView {
        self.widthAnchor.constraint(equalTo: to.widthAnchor, multiplier: multiplier).isActive = true
        return self
    }
    
    func proportionalHeight(to: UIView, multiplier: CGFloat = 0) -> UIView {
        self.heightAnchor.constraint(equalTo: to.widthAnchor, multiplier: multiplier).isActive = true
        return self
    }

    func height(to: UIView) -> UIView {
        self.heightAnchor.constraint(equalTo: to.heightAnchor).isActive = true

        return self
    }

    func ratio(constant: CGFloat) -> UIView {
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }

    func equalHeight(height: NSLayoutAnchor<NSLayoutDimension>) -> UIView {

        self.heightAnchor.constraint(equalTo: height).isActive = true
        return self
    }

    func equalWith(width: NSLayoutAnchor<NSLayoutDimension>) -> UIView {

        self.widthAnchor.constraint(equalTo: width).isActive = true
        return self
    }

    func greaterThanOrEqualWidth(constant: CGFloat) -> UIView {
        self.widthAnchor.constraint(greaterThanOrEqualToConstant: constant).isActive = true
        return self
    }

    func greaterThanOrEqualHeight(constant: CGFloat) -> UIView {
        self.heightAnchor.constraint(greaterThanOrEqualToConstant: constant).isActive = true
        return self
    }
    func setBackground(_ imageName: String) {
         let imageViewback: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.image = UIImage(named: imageName)
            imageView.contentMode = .scaleToFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        self.insertSubview(imageViewback, at: 0)
           NSLayoutConstraint.activate([
               imageViewback.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
               imageViewback.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
               imageViewback.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
               imageViewback.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 30)
           ])
    }
}
