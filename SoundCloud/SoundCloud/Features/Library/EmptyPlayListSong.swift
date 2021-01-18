//
//  EmptyLibraryTableViewCell.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/13/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit

protocol EmptyPlayListSongView: class {
    func tapOnCreatePlayList()
}

class EmptyPlayListSong: BaseView {

    // MARK: - Variables
    
    weak var delegate: EmptyPlayListSongView?
    
    // MARK: - UI Elements
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: FontSize.headline.rawValue, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = TextManager.createPlaylist
        return label
    }()
    
    fileprivate lazy var supportTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: FontSize.h1.rawValue)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = TextManager.descriptionList
        return label
    }()
    
    fileprivate lazy var createPlayListButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextManager.createPlayList, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize.h1.rawValue, weight: .semibold)
        button.setTitleColor(UIColor.black, for: .normal)
        button.contentHorizontalAlignment = .center
        button.layer.cornerRadius = 25
        button.backgroundColor = UIColor.white
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(tapCreatePlayList), for: .touchUpInside)
        return button
    }()
    
    // MARK: - View LifeCycles
    
    
    override func initialize() {
        super.initialize()
        layoutTitleLabel()
        layoutSupportTitleLabel()
        layoutCreatePlayListButton()
    }
    
    @objc private func tapCreatePlayList() {
        delegate?.tapOnCreatePlayList()
    }
    
    private func layoutTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(Dimension.shared.largeMargin_90)
            make.centerX.equalToSuperview()
            make.width.equalTo(Dimension.shared.widthLabelLarge_300)
        }
    }
    
    private func layoutSupportTitleLabel() {
        addSubview(supportTitleLabel)
        supportTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(Dimension.shared.normalMargin)
            make.width.equalTo(titleLabel)
            make.centerX.equalToSuperview()
        }
    }
    
    private func layoutCreatePlayListButton() {
        addSubview(createPlayListButton)
        createPlayListButton.snp.makeConstraints { (make) in
            make.top.equalTo(supportTitleLabel.snp.bottom).offset(Dimension.shared.largeMargin_25)
            make.height.equalTo(Dimension.shared.largeHeightButton)
            make.width.equalTo(Dimension.shared.largeWidthButton)
            make.centerX.equalToSuperview()
        }
    }
    
}
