//
//  TimeLineViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/3/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class TimeLineCollectionViewCell: BaseCollectionViewCell {

    // MARK: - Variables
    
    fileprivate lazy var trackModel: TrackModel = {
        let trackModel = TrackModel()
        return trackModel
    }()
    
    // MARK: - UI Elements
    
    fileprivate lazy var timeLineCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0 , right: 16)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.registerReusableCell(TabCellCollectionViewCell.self)
        return collectionView
    }()
    
    
    // MARK: - View LifeCycles
    
    override func initialize() {
        super.initialize()
        layoutTimeLineCollectionView()
    }
    
    // MARK: - Layout
    
    private func layoutTimeLineCollectionView() {
        addSubview(timeLineCollectionView)
        timeLineCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}

// MARK: - UICollectionViewDelegate

extension TimeLineCollectionViewCell: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource

extension TimeLineCollectionViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trackModel.imageTrack.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TabCellCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configCell(image: trackModel.imageTrack[indexPath.row], name: trackModel.nameTrack[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TimeLineCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 8 - 32) / 2
        return CGSize(width: width, height: 56)
    }
}
