//
//  LibraryTableViewCell.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/13/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit

class LibraryTableViewCell: BaseTableViewCell {

    fileprivate lazy var songImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: FontSize.h1.rawValue, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    fileprivate lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: FontSize.h3.rawValue)
        label.textAlignment = .left
        return label
    }()
    
    override func initialize() {
        super.initialize()
        backgroundColor = .clear
        layoutSongImageView()
        layoutTitleLabel()
        layoutDescriptionLabel()
    }
    
    public func configLikeSong(image: UIImage?, title: String, description: String) {
        songImageView.image = image
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
    public func configCell(song: SongTrack) {
        
    }
    
    private func layoutSongImageView() {
        addSubview(songImageView)
        songImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(60)
            make.left.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    
    private func layoutTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(songImageView.snp.right).offset(Dimension.shared.normalMargin)
            make.centerY.equalTo(songImageView)
            make.right.equalToSuperview().offset(-Dimension.shared.normalMargin)
        }
    }
    
    private func layoutDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(Dimension.shared.smallMargin)
            make.left.right.equalTo(titleLabel)
        }
    }
}
