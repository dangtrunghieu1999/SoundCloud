
//
//  HotNowCollectionViewCell.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 9/23/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class HotNowCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Variables
    
    fileprivate lazy var playlistModel: PlayList = {
         let model = PlayList()
         return model
     }()
    
    // MARK: - UI Elements
    
    fileprivate lazy var hotNowCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        collectionView.registerReusableCell(ItemCollectionViewCell.self)
        return collectionView
    }()
    
    // MARK: - View LifeCycles
    
    override func initialize() {
        super.initialize()
        layouthHotNowCollectionView()
    }
    
    // MARK:- Helper Method
    
    // MARK: - UI Actions
    
    // MARK: - Public Method
    
    // MARK: - Layouts
    private func layouthHotNowCollectionView() {
        addSubview(hotNowCollectionView)
        hotNowCollectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HotNowCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 3 * 20) / 2
        return CGSize( width: width, height: collectionView.frame.height)
    }
}

// MARK: - UICollectionViewDelegate

extension HotNowCollectionViewCell: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource

extension HotNowCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlistModel.playlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ItemCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configCell(image: playlistModel.playlist[indexPath.row])
        return cell
    }
}




