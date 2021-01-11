//
//  SettingFooterView.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/11/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit

class SettingFooterView: BaseTableViewHeaderFooter {
    
    private let logOutButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextManager.logout, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize.h1.rawValue, weight: .semibold)
        button.setTitleColor(UIColor.mainBackground, for: .normal)
        button.contentHorizontalAlignment = .center
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = Dimension.shared.largeHeightButton / 2
        return button
    }()
    
    override func initialize() {
        super.initialize()
        layoutLogOutButton()
    }
    
    private func layoutLogOutButton() {
        addSubview(logOutButton)
        logOutButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.width.equalTo(Dimension.shared.largeWidthButton)
            make.height.equalTo(Dimension.shared.largeHeightButton)
            make.centerX.equalToSuperview()
        }
    }
}
