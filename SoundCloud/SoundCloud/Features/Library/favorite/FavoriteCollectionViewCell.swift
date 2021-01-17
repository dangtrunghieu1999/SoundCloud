//
//  FavoriteCollectionViewCell.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/17/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit

class FavoriteCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UI Elements
    
    fileprivate lazy var songImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    fileprivate lazy var songTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.preferredFont(forTextStyle: .body).withTraits(traits: .traitBold)
        label.textAlignment = .left
        label.numberOfLines = 1
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
    
    fileprivate lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageManager.like, for: .normal)
        button.layer.masksToBounds = true
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    // MARK: - View Life Cycles
    
    override func initialize() {
        super.initialize()
        layoutSongImageView()
        layoutStackView()
        layoutLikeButton()
        backgroundColor = UIColor.spotifyBrown
    }
    
    public func configCell(song: Song?) {
        guard let song = song else { return }
        let url = URL(string: song.image)
        songImageView.sd_setImage(with: url)
        songTitleLabel.text  = song.title.capitalizingFirstLetter()
        let artist = CommonMethod.convertArrayToStringText(data: song.listArtists)
        artistTitleLabel.text = artist.capitalizingFirstLetter()
    }
    
    private func layoutSongImageView() {
        addSubview(songImageView)
        songImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalTo(65)
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
            make.right.equalToSuperview().offset(-Dimension.shared.largeMargin_90)
        }
    }
    
    private func layoutLikeButton() {
        addSubview(likeButton)
        likeButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-Dimension.shared.normalMargin)
            make.width.height.equalTo(16)
            make.centerY.equalToSuperview()
        }
    }
}
