//
//  SongCollectionViewCell.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/22/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class SongCollectionViewCell: BaseCollectionViewCell {
    
    var track: TrackSong? {
        didSet {
            guard let track = track else { return }
            let image = UIImage(named: track.imageName) ?? UIImage(named: "placeholder")!
            
            songImageView.image  = image
            songTitleLabel.text  = track.title
            artistTitleLabel.text = track.artist
        }
    }
    
    fileprivate lazy var songImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate lazy var songTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.preferredFont(forTextStyle: .body).withTraits(traits: .traitBold)
        label.textAlignment = .left
        return label
    }()
    
    fileprivate lazy var artistTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.alpha = 0.7
        return label
    }()
    
    fileprivate lazy var likeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageManager.like
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    fileprivate lazy var moreImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageManager.more
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    override func initialize() {
        super.initialize()
        layoutSongImageView()
        layoutStackView()
        layoutMoreImageView()
        layoutLikeImageView()
    }
    
    private func layoutSongImageView() {
        addSubview(songImageView)
        songImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.width.height.equalTo(50)
            make.left.equalToSuperview().offset(Dimension.shared.normalMargin)
        }
    }

    private func layoutStackView() {
        let stackView = makeStackView(axis: .vertical)
        stackView.spacing = 6
        stackView.addArrangedSubview(songTitleLabel)
        stackView.addArrangedSubview(artistTitleLabel)
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(songImageView.snp.right).offset(Dimension.shared.mediumMargin)
            make.right.equalToSuperview().offset(-Dimension.shared.normalMargin)
        }
    }
    
    private func layoutMoreImageView() {
        addSubview(moreImageView)
        moreImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-Dimension.shared.normalMargin)
            make.width.height.equalTo(16)
        }
    }
    
    private func layoutLikeImageView() {
        addSubview(likeImageView)
        likeImageView.snp.makeConstraints { (make) in
            make.right.equalTo(moreImageView.snp.left).offset(-Dimension.shared.normalMargin * 2)
            make.width.height.equalTo(16)
            make.centerY.equalTo(moreImageView)
        }
    }

}
