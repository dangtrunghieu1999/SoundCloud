//
//  CreateYourLibraryTableView.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/13/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit

class CreateYourLibraryTableView: BaseTableViewHeaderFooter {

    weak var delegate: EmptyPlayListSongView?
    
    // MARK: - UI Elements
    
    fileprivate lazy var createPlayListButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.contentMode = .scaleAspectFit
        button.setImage(ImageManager.create, for: .normal)
        button.addTarget(self, action: #selector(tapCreatePlayList), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: FontSize.h1.rawValue, weight: .semibold)
        label.textAlignment = .left
        label.text = TextManager.createPlay
        return label
    }()
    
    override func initialize() {
        super.initialize()
        layoutCreatePlayListButton()
        layoutTitleLabel()
    }
    
    @objc private func tapCreatePlayList() {
        delegate?.tapOnCreatePlayList()
    }
    
    private func layoutCreatePlayListButton() {
        addSubview(createPlayListButton)
        createPlayListButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(60)
            make.left.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    
    private func layoutTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(createPlayListButton.snp.right).offset(Dimension.shared.normalMargin)
            make.centerY.equalTo(createPlayListButton)
            make.right.equalToSuperview().offset(-Dimension.shared.normalMargin)
        }
    }
    
}
