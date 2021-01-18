//
//  ImageCollectionViewCell.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/17/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UI Elements
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()

    // MARK: - Life Cycles
    
    override func initialize() {
        super.initialize()
        backgroundColor = .clear
        layoutImageView()
    }
    
    // MARK: - Public Method
    
    public func configCell(image: UIImage?) {
        imageView.image = image
    }
    
    // MARK: - Layout
    
    private func layoutImageView() {
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(Dimension.shared.normalMargin)
            make.right.equalToSuperview().offset(-Dimension.shared.normalMargin)
            make.bottom.equalToSuperview()
        }
    }
}
