//
//  FavoriteHeaderCollectionReusableView.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/17/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit

class FavoriteHeaderCollectionReusableView: BaseCollectionViewHeaderFooterCell {
 
    // MARK: - UI Elemenets
    weak var delegate: HeaderViewCollectionReusableViewDelegate?
    
    fileprivate lazy var favoriteTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = TextManager.favorite
        label.font = UIFont.systemFont(ofSize: FontSize.headline.rawValue, weight: .bold)
        label.textColor = UIColor.white
        return label
    }()
    
    fileprivate lazy var shuffleSongButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextManager.shuffle, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize.h1.rawValue, weight: .semibold)
        button.setTitleColor(UIColor.white, for: .normal)
        button.contentHorizontalAlignment = .center
        button.layer.cornerRadius = 25
        button.backgroundColor = UIColor.spotifyGreen
        button.addTarget(self, action: #selector(tapOnShufflePlay), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var addSongButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextManager.addSong, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize.h3.rawValue, weight: .semibold)
        button.setTitleColor(UIColor.white, for: .normal)
        button.contentHorizontalAlignment = .center
        button.backgroundColor = UIColor.spotifyBrown
        button.layer.cornerRadius = Dimension.shared.mediumHeightButton / 2
        return button
    }()
    
    override func initialize() {
        super.initialize()
        layoutFavoriteTitleLabel()
        layoutShuffleSongButton()
        layoutAddSongButton()
    }
    
    @objc private func tapOnShufflePlay() {
        delegate?.playRandom()
    }
    
    private func layoutFavoriteTitleLabel() {
        addSubview(favoriteTitleLabel)
        favoriteTitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(Dimension.shared.normalMargin)
            make.left.equalToSuperview().offset(Dimension.shared.normalMargin)
            make.right.equalToSuperview().offset(-Dimension.shared.normalMargin)
        }
    }
    
    private func layoutShuffleSongButton() {
        addSubview(shuffleSongButton)
        shuffleSongButton.snp.makeConstraints { (make) in
            make.top.equalTo(favoriteTitleLabel.snp.bottom).offset(Dimension.shared.largeMargin_25)
            make.height.equalTo(Dimension.shared.largeHeightButton)
            make.centerX.equalToSuperview()
            make.width.equalTo(Dimension.shared.mediumWidthButton)
        }
    }
    
    private func layoutAddSongButton() {
        addSubview(addSongButton)
        addSongButton.snp.makeConstraints { (make) in
            make.top.equalTo(shuffleSongButton.snp.bottom).offset(Dimension.shared.normalMargin)
            make.width.equalTo(Dimension.shared.largeWidthButton)
            make.height.equalTo(Dimension.shared.mediumHeightButton)
            make.centerX.equalToSuperview()
        }
    }

}
