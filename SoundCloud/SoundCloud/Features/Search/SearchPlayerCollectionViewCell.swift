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
        layoutSongSearchImageView()
    }
    
    // MARK: - Method Helper
    
    public func configCell(songImage: UIImage?) {
        self.songSearchImageView.image = songImage
    }
    
    // MARK: - Layout
    
    private func layoutSongSearchImageView() {
        addSubview(songSearchImageView)
        songSearchImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(Dimension.shared.largeMargin_25)
            make.left.right.equalToSuperview()
            make.height.equalTo(105)
        }
    }
}
