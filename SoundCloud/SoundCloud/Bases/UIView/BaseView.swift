//
//  BaseView.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/28/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

open class BaseView: UIView {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.mainBackground
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initialize() {}
}
