//
//  SongCollectionViewCell.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/22/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

protocol SongAddFavoriteDelegate: class {
    func addSongFavorite(idSong: String)
}

class SongCollectionViewCell: BaseCollectionViewCell {
    
    weak var delegate: SongAddFavoriteDelegate?
    var idCurrentSong = ""
    var isSelectedLike = false
    
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
        button.addTarget(self, action: #selector(addSongFavorite), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageManager.more,for: .normal)
        button.layer.masksToBounds = true
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    fileprivate lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageManager.next,for: .normal)
        button.layer.masksToBounds = true
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    override func initialize() {
        super.initialize()
        layoutSongImageView()
        layoutStackView()
        layoutMoreButton()
        layoutLikeButton()
    }
    
    @objc private func addSongFavorite() {
        delegate?.addSongFavorite(idSong: idCurrentSong)
        if isSelectedLike {
            isSelectedLike = false
            likeButton.setImage(ImageManager.likeFocus, for: .normal)
        } else {
            likeButton.setImage(ImageManager.like, for: .normal)
            isSelectedLike = true
        }
    }
        
    public func configCell(song: Song?) {
        guard let song = song else { return }
        let url = URL(string: song.image)
        songImageView.sd_setImage(with: url)
        songTitleLabel.text  = song.title.capitalizingFirstLetter()
        let artist = CommonMethod.convertArrayToStringText(data: song.listArtists)
        artistTitleLabel.text = artist.capitalizingFirstLetter()
        self.idCurrentSong = song.id
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
            make.right.equalToSuperview().offset(-Dimension.shared.largeMargin_90)
        }
    }
    
    private func layoutMoreButton() {
        addSubview(moreButton)
        moreButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-Dimension.shared.normalMargin)
            make.width.height.equalTo(16)
        }
    }
    
    private func layoutLikeButton() {
        addSubview(likeButton)
        likeButton.snp.makeConstraints { (make) in
            make.right.equalTo(moreButton.snp.left).offset(-Dimension.shared.normalMargin * 2)
            make.width.height.equalTo(16)
            make.centerY.equalTo(moreButton)
        }
    }
    
    private func layoutNextButton() {
        addSubview(nextButton)
        nextButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-Dimension.shared.normalMargin)
            make.width.height.equalTo(16)
        }
    }
    
}


