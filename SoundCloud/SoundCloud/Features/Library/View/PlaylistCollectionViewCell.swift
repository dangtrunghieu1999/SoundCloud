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
    
    fileprivate lazy var yourHomeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.registerReusableCell(TrackCollectionViewCell.self)
        return collectionView
    }()
    
    override func initialize() {
        super.initialize()
    }
}

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
