//
//  SettingHeaderView.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/11/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit

protocol SettingHeaderViewDelegate: class {
    func tapOnSettingProfile()
}

class SettingHeaderView: BaseTableViewHeaderFooter {
    
    weak var delegate: SettingHeaderViewDelegate?
    
    fileprivate lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Dimension.shared.widthAvatarDefault / 2
        imageView.image = UIImage(named: "1")
        return imageView
    }()
    
    fileprivate lazy var userNameTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: FontSize.headline.rawValue, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Trung Hieu"
        return label
    }()
    
    private let settingProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextManager.settingProfile, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize.h3.rawValue, weight: .semibold)
        button.setTitleColor(UIColor.white, for: .normal)
        button.contentHorizontalAlignment = .center
        button.backgroundColor = UIColor.spotifyBrown
        button.layer.cornerRadius = Dimension.shared.mediumHeightButton / 2
        button.addTarget(self, action: #selector(tapOnSettingProfile), for: .touchUpInside)
        return button
    }()
    
    override func initialize() {
        super.initialize()
        layoutAvatarImageView()
        layoutUserNameTextField()
        layoutSettingProfileButton()
    }
    
    @objc func tapOnSettingProfile() {
        delegate?.tapOnSettingProfile()
    }
    
    private func layoutAvatarImageView() {
        addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(Dimension.shared.widthAvatarDefault)
            make.top.equalToSuperview().offset(Dimension.shared.largeMargin_30)
            make.centerX.equalToSuperview()
        }
    }
    
    private func layoutUserNameTextField() {
        addSubview(userNameTitleLabel)
        userNameTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImageView.snp.bottom).offset(Dimension.shared.normalMargin)
            make.width.equalTo(Dimension.shared.widthLabelLarge_300)
            make.centerX.equalToSuperview()
        }
    }
    
    private func layoutSettingProfileButton() {
        addSubview(settingProfileButton)
        settingProfileButton.snp.makeConstraints { (make) in
            make.top.equalTo(userNameTitleLabel.snp.bottom).offset(Dimension.shared.normalMargin)
            make.width.equalTo(Dimension.shared.mediumWidthButton)
            make.centerX.equalToSuperview()
            make.height.equalTo(Dimension.shared.mediumHeightButton)
        }
    }
    
}
