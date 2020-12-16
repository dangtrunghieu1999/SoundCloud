//
//  SearchPlayerCollectionViewCell.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/16/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class SearchPlayerCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UI Elemenets
    
    fileprivate lazy var songSearchTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: FontSize.h1.rawValue)
        label.textAlignment = .left
        return label
    }()
    
    fileprivate lazy var songSearchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    // MARK: - View LifeCycles
    
    override func initialize() {
        super.initialize()
        layoutSongSearchTitleLabel()
        layoutSongSearchImageView()
    }
    
    // MARK: - Method Helper
    
    public func configCell(songSearch: String, songImage: UIImage?) {
        self.songSearchTitleLabel.text = songSearch
        self.songSearchImageView.image = songImage
    }
    
    // MARK: - Layout
    
    private func layoutSongSearchTitleLabel() {
        addSubview(songSearchTitleLabel)
        songSearchTitleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    private func layoutSongSearchImageView() {
        addSubview(songSearchImageView)
        songSearchImageView.snp.makeConstraints { (make) in
            make.top.equalTo(songSearchTitleLabel.snp.bottom).offset(Dimension.shared.largeMargin_25)
            make.left.right.equalToSuperview()
            make.height.equalTo(105)
        }
    }
}
