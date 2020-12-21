//
//  UIFont+Extension.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 9/23/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

enum FontSize: CGFloat {
    case superHeadline  = 36.0
    case headline       = 24.0
    case mediumLine     = 22.0
    
    case title          = 20.0
    case body           = 18.0
    
    case h1             = 16.0
    case h2             = 14.0
    case h3             = 11.0
    case h4             = 8.0
    
    case paragraph      = 6.0
}

extension UIFont {
    func width(for string: String, constrainedToHeight height: CGFloat) -> CGFloat {
        return NSString(string: string).boundingRect(with: CGSize(width: .greatestFiniteMagnitude, height: height),
                                                     options: .usesLineFragmentOrigin,
                                                     attributes: [NSAttributedString.Key.font: self],
                                                     context: nil).size.width
    }
    
    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0)
    }

    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }

}
