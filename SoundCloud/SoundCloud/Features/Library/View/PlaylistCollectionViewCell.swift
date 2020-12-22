//
//  PlaylistCollectionViewCell.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/21/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class PlaylistCollectionViewCell: BaseCollectionViewCell {
    
    var tracks: [Track]?
    
    // MARK: - UI Elements
    
    fileprivate lazy var playListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerReusableCell(TrackCollectionViewCell.self)
        return collectionView
    }()
    
    // MARK: - View LifeCycles
    
    override func initialize() {
        super.initialize()
        layoutPlayListCollectionView()
    }
    
    // MARK: - Layout
    
    private func layoutPlayListCollectionView() {
        addSubview(playListCollectionView)
        playListCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension PlaylistCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let tracks = tracks else { return 0 }
        return tracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TrackCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.track = tracks?[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PlaylistCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 80)
    }
}

struct Track {
    let imageName: String
    let title: String
    let artist: String
}
