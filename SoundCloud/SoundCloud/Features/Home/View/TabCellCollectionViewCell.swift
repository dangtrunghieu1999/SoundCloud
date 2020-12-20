//
//  TabCellCollectionViewCell.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/3/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class TabCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Variables
    
    lazy var playlists = [PlayList]()
    
    // MARK: - UI Elements
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: FontSize.headline.rawValue, weight: .bold)
        label.textColor = .white
        return label
    }()
        
    private lazy var tabCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerReusableCell(SongPlayerCollectionViewCell.self)
        return collectionView
    }()

    
    // MARK: - View LifeCycles
    
    override func initialize() {
        super.initialize()
        backgroundColor = UIColor.background
        layoutTitleLabel()
        layoutTabCollecionView()
    }
        
    // MARK: - Layouts
    
    private func layoutTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(Dimension.shared.normalMargin)
            make.top.equalToSuperview().offset(Dimension.shared.mediumMargin)
        }
    }
    
    private func layoutTabCollecionView() {
        addSubview(tabCollectionView)
        tabCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(Dimension.shared.normalMargin)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

extension TabCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
}

extension TabCollectionViewCell: UICollectionViewDataSource {
    
}
