//
//  MadeForYouCollectionViewCell.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/3/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class MadeForYouCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Variables
    
    fileprivate lazy var trackModel: TrackModel = {
        let trackModel = TrackModel()
        return trackModel
    }()
    
    // MARK: - UI Elements
    
    fileprivate lazy var recentlyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.scrollDirection = .horizontal
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0 , right: 16)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.registerReusableCell(SongPlayerCollectionViewCell.self)
        return collectionView
    }()
    
    
    // MARK: - View LifeCycles
    
    override func initialize() {
        super.initialize()
        layoutRecentlyCollectionView()
    }
    
    // MARK: - Layout
    
    private func layoutRecentlyCollectionView() {
        addSubview(recentlyCollectionView)
        recentlyCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDelegate

extension MadeForYouCollectionViewCell: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource

extension MadeForYouCollectionViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trackModel.songTrack.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SongPlayerCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configCell(image: trackModel.songTrack[indexPath.row], name: trackModel.songName[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MadeForYouCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 16 * 2 - 32) / 2.6
        return CGSize(width: width, height: 145)
    }
}
