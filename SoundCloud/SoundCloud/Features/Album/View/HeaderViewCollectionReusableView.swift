//
//  HeaderViewCollectionReusableView.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/22/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class HeaderViewCollectionReusableView: BaseCollectionViewHeaderFooterCell {
    
    // MARK: - UI Elements
    
    fileprivate lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "header")
        return imageView
    }()
    
    
    // MARK: - View LifeCycles
    
    override func initialize() {
        super.initialize()
        layoutImageView()
    }
    
    private func layoutImageView() {
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.top.left.equalToSuperview().offset(Dimension.shared.normalMargin)
        }
    }
}
