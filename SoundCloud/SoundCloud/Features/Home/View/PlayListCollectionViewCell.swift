//
//  PlayListCollectionViewCell.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/3/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class PlayListCollectionViewCell: BaseCollectionViewCell {
    
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
        layoutTrackImageView()
        layoutNameTrackLabel()
    }
    
    public func configCell(song: PlayList?) {
        guard let song = song else { return }
        let url = URL(string: song.image)
        self.trackImageView.sd_setImage(with: url)
        self.nameTrackLabel.text  = song.name
    }
    
    // MARK: - Layouts
    
    private func layoutTrackImageView() {
        addSubview(trackImageView)
        trackImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(130)
        }
    }
    
    private func layoutNameTrackLabel() {
        addSubview(nameTrackLabel)
        nameTrackLabel.snp.makeConstraints { (make) in
            make.top.equalTo(trackImageView.snp.bottom).offset(Dimension.shared.mediumMargin)
            make.left.right.equalToSuperview()
        }
    }
}
