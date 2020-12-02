//
//  ItemCollectionViewCell.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 9/23/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Variables
    
    // MARK: - UI Elements
    
    fileprivate lazy var playListImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageManager.icon_owner
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    fileprivate lazy var topicTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Summer Vibes"
        label.textColor = UIColor.titleText
        label.font = UIFont.systemFont(ofSize: FontSize.h1.rawValue)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate lazy var numberFollowLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: FontSize.h4.rawValue)
        label.text = "300.321"
        label.textColor = UIColor.titleText
        return label
    }()
    
    private let titleFollowLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: FontSize.h3.rawValue)
        label.text = "FOLLOWERS"
        label.textColor = UIColor.titleText
        return label
    }()
    
    
    
    // MARK: - View LifeCycles
    
    override func initialize() {
        super.initialize()
        layoutPlayListImageView()
        layoutIconLabel()
        layoutTopicTitleLabel()
        layoutNumberFollowLabel()
        layoutFollowTitleLabel()
    }
    
    // MARK:- Helper Method
    
    public func configCell(image: UIImage?) {
        playListImageView.image = image
    }
    
    // MARK: - UI Actions
    
    // MARK: - Public Method
    
    // MARK: - Layouts
    
    private func layoutPlayListImageView() {
        addSubview(playListImageView)
        playListImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(150)
        }
    }

    private func layoutIconLabel() {
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(playListImageView)
            make.height.equalTo(7)
            make.width.equalTo(15)
            make.bottom.equalTo(playListImageView).offset(-10)
        }
    }
    
    private func layoutTopicTitleLabel() {
        addSubview(topicTitleLabel)
        topicTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(playListImageView.snp.bottom).offset(5)
            make.centerX.equalTo(playListImageView)
        }
    }
    
    private func layoutNumberFollowLabel() {
        addSubview(numberFollowLabel)
        numberFollowLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topicTitleLabel.snp.bottom).offset(3)
            make.centerX.equalTo(playListImageView)
        }
    }
    
    private func layoutFollowTitleLabel() {
        addSubview(titleFollowLabel)
        titleFollowLabel.snp.makeConstraints { (make) in
            make.top.equalTo(numberFollowLabel.snp.bottom)
            make.centerX.equalTo(playListImageView)
        }
    }
    
}


