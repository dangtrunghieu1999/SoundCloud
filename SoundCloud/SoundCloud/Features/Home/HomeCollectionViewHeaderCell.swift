//
//  HomeCollectionViewHeaderCell.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 9/23/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class HomeCollectionViewHeaderCell: BaseCollectionViewHeaderFooterCell {
    
    // MARK: - Variables
    var titleName: String? {
        didSet{
            titleLabel.text = titleName
        }
    }
    
    var titleColor: UIColor? {
        didSet {
            titleLabel.textColor = titleColor
        }
    }
    
    var fontSize: UIFont? {
        didSet {
            titleLabel.font = fontSize
        }
    }
    
    // MARK: - UI Elements
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: FontSize.headline.rawValue, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - View LifeCycles
    
    override func initialize() {
        super.initialize()
        layoutTitleLabel()
    }
    
    // MARK:- Helper Method
    
    // MARK: - UI Actions
    
    // MARK: - Public Method
    
    // MARK: - Layouts
    
    private func layoutTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(Dimension.shared.largeMargin)
        }
    }
    
}
