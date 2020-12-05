//
//  TabCellCollectionViewCell.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/3/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class TabCellCollectionViewCell: BaseCollectionViewCell {
 
    // MARK: - UI Elements
    
    fileprivate lazy var trackImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    fileprivate lazy var nameTrackLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: FontSize.h2.rawValue, weight: .medium)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - View LifeCycles
    
    override func initialize() {
        super.initialize()
        backgroundColor = UIColor.background
        layoutTrackImageView()
        layoutNameTrackLabel()
    }
    
    public func configCell(image: UIImage?, name: String?) {
        self.trackImageView.image = image
        self.nameTrackLabel.text  = name
    }
    
    // MARK: - Layouts
    
    private func layoutTrackImageView() {
        addSubview(trackImageView)
        trackImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.height.equalTo(56)
        }
    }
    
    private func layoutNameTrackLabel() {
        addSubview(nameTrackLabel)
        nameTrackLabel.snp.makeConstraints { (make) in
            make.left.equalTo(trackImageView.snp.right).offset(8)
            make.centerY.equalTo(trackImageView)
            make.right.equalToSuperview().offset(-4)
        }
    }
}
