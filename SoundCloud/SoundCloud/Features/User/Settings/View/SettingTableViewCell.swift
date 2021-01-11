//
//  SettingTableViewCell.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/10/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit

class SettingTableViewCell: BaseTableViewCell {
    
    
    // MARK: - UI ELements
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: FontSize.h2.rawValue, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageManager.next, for: .normal)
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    // MARK: - View LifeCycles
    
    override func initialize() {
        super.initialize()
        layoutTitleLabel()
        layoutNextButton()
        backgroundColor = .mainBackground
    }
    
    
    // MARK: - Public Method
    
    func configCell(title: String) {
        self.titleLabel.text = title
    }
    
    // MARK: - Layout
    
    private func layoutTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func layoutNextButton() {
        addSubview(nextButton)
        nextButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(Dimension.shared.mediumHeightButton_24)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
}
