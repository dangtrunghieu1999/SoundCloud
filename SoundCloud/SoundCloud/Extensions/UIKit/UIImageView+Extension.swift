//
//  UIImageView+Extension.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/2/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func dropShadow(scale: Bool = true) {
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 2, height: 3)
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
    }
    
    func makeVisualEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    
}
