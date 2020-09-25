
//
//  MoodCollectionViewCell.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 9/23/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class MoodCollectionViewCell: BaseCollectionViewCell {
    
    fileprivate lazy var moodlistModel: PlayList = {
        let model = PlayList()
        return model
    }()
    
    // MARK: - Variables
    
    // MARK: - UI Elements
    
    fileprivate lazy var moodCollectionView: UICollectionView = {
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
        layouthMoodCollectionView()
    }
    
    // MARK:- Helper Method
    
    // MARK: - UI Actions
    
    // MARK: - Public Method
    
    // MARK: - Layouts
    private func layouthMoodCollectionView() {
        addSubview(moodCollectionView)
        moodCollectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MoodCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 3 * 20) / 2
        return CGSize( width: width, height: collectionView.frame.height)
    }
}

// MARK: - UICollectionViewDelegate

extension MoodCollectionViewCell: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource

extension MoodCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moodlistModel.moodlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ItemCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configCell(image: moodlistModel.moodlist[indexPath.row])
        return cell
    }
}


