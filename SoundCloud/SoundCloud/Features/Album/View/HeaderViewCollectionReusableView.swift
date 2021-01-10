//
//  HeaderViewCollectionReusableView.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/22/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class HeaderViewCollectionReusableView: BaseCollectionViewHeaderFooterCell {
    
    // MARK: - Variables

    // MARK: - UI Elements
    
    fileprivate lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "type1")
        return imageView
    }()
    
    fileprivate lazy var titleAlbumLabel: UILabel = {
        let label = UILabel()
        label.text = "Nhạc việt"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: FontSize.headline.rawValue, weight: .bold)
        return label
    }()
    
    private let savePlayListButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageManager.like, for: .normal)
        button.layer.masksToBounds = true
        return button
    }()
    
    private let seeMoreButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageManager.more, for: .normal)
        button.layer.masksToBounds = true
        return button
    }()
    
    private let songPlayAllButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageManager.playAll, for: .normal)
        button.layer.masksToBounds = true
        return button
    }()
    
    
    
    // MARK: - View LifeCycles
    
    override func initialize() {
        super.initialize()
        layoutImageView()
        layoutTitleAlbumLabel()
        layoutSavePlayListButton()
        layoutSeeMoreButton()
        layoutSongPlayAllButton()
    }
    
    private func layoutImageView() {
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(Dimension.shared.normalMargin)
            make.right.equalToSuperview().offset(-Dimension.shared.normalMargin)
            make.height.equalTo(250)
        }
    }
    
    private func layoutTitleAlbumLabel() {
        addSubview(titleAlbumLabel)
        titleAlbumLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(Dimension.shared.normalMargin)
            make.left.right.equalTo(imageView)
        }
    }
    
    private func layoutSavePlayListButton() {
        addSubview(savePlayListButton)
        savePlayListButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(25)
            make.left.equalTo(imageView)
            make.top.equalTo(titleAlbumLabel.snp.bottom).offset(Dimension.shared.mediumMargin)
        }
    }
    
    private func layoutSeeMoreButton() {
        addSubview(seeMoreButton)
        seeMoreButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(25)
            make.left.equalTo(savePlayListButton.snp.right).offset(Dimension.shared.largeMargin_25)
            make.top.equalTo(savePlayListButton)
        }
    }
    
    private func layoutSongPlayAllButton() {
        addSubview(songPlayAllButton)
        (songPlayAllButton).snp.makeConstraints { (make) in
            make.width.height.equalTo(55)
            make.right.equalTo(imageView)
            make.top.equalTo(imageView.snp.bottom).offset(Dimension.shared.normalMargin)
        }
    }
    
    
}

