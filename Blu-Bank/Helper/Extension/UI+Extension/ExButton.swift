//
//  ExButton.swift
//  Blu-Bank
//
//  Created by Nik on 14/09/2025.
//

import UIKit

extension UIButton {
    func setFont(font: UIFont) -> UIButton {
        titleLabel?
            .setFont(font: font)
            .closed()
        
        return self
    }
    
    func setTitle(title: String = "", icon: UIImage? = nil) -> UIButton {
        self.setTitle(title, for: .normal)
        
        if let img = icon {
            setImage(img, for: .normal)
        }
        return self
    }
    
    func setColor(color: UIColor, _ state: UIControl.State? = nil ) -> UIButton {
        setTitleColor(color, for: state ?? .normal)
        return self
    }
    
    func setColor(hex: String) -> UIButton {
        let color = UIColor.fromHex(hex: hex)
        setTitleColor(color, for: .normal)
        return self
    }
    
    func setBackgroundColor(color: UIColor) -> UIButton {
        backgroundColor = color
        return self
    }
    
    func setBackgroundColor(hex: String) -> UIButton {
        let color = UIColor.fromHex(hex: hex)
        backgroundColor = color
        return self
    }
    
    @objc func underline() {
        if let textString = self.titleLabel?.text {
            
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSRange(location: 0, length: textString.count))
            self.setAttributedTitle(attributedString, for: .normal)
        }
    }
    
    func addIconTitel(titel: String, image: String, location: NSDirectionalRectEdge) -> UIButton {
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.plain()
            let image = UIImage(named: image)
            configuration.image = image
            configuration.imagePadding = 8.0
            configuration.imagePlacement = location
            self.configuration = configuration
            self.setTitle(titel, for: .normal)
            self.titleLabel!.font = UIFont(name: "Vazir-Medium-FD", size: 14)
        } else {
            let buttonTitle = titel
            let titleAttributedString = NSMutableAttributedString(string: buttonTitle + " ")
            let textAttachment = NSTextAttachment(image: UIImage(named: image)!)
            let textAttachmentAttributedString = NSAttributedString(attachment: textAttachment)
            titleAttributedString.append(textAttachmentAttributedString)
            self.setAttributedTitle(titleAttributedString, for: .normal)
            // When using NSTextAttachment, configure an accessibility label manually either
            // replacing it for something meaningful or removing the attachment from it
            // (whatever makes sense), otherwise, VoiceOver will announce the name of the
            // SF symbol or "Atachement.png, File" when using an image
            self.accessibilityLabel = buttonTitle
        }
        return self
    }
    
    func disabl() {
        DispatchQueue.main.async {
            self.isEnabled = false
        }
    }
    
    func enable() {
        DispatchQueue.main.async {
            self.isEnabled = true
        }
    }

    func enableEmpty() {
        DispatchQueue.main.async {
            self.setTitleColor(UIColor.systemGreen, for: .normal)
            self.layer.borderColor = UIColor.systemGreen.cgColor
            self.layer.borderWidth = 1
            self.isEnabled = true
        }
    }
}
// MARK: - ----------------- Add Image left side or righte side of the button
extension UIButton {
    
    /// Add left icon with spacing (default: 8 points)
    func addLeftIcon(image: UIImage, renderMode: UIImage.RenderingMode = .alwaysOriginal, spacing: CGFloat = 8) {
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        self.semanticContentAttribute = .forceLeftToRight
        self.contentHorizontalAlignment = .center
        
        // Set edge insets for spacing
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: spacing/2)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
    }
    
    /// Add right icon with spacing (default: 8 points)
    func addRightIcon(image: UIImage, renderMode: UIImage.RenderingMode = .alwaysOriginal, spacing: CGFloat = 8) {
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        self.semanticContentAttribute = .forceRightToLeft
        self.contentHorizontalAlignment = .center
        
        // Set edge insets for spacing
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: spacing/2)
    }
}
