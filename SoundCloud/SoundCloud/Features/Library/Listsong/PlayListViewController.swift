//
//  PlayListViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/16/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit

class PlayListViewController: BaseViewController {

    fileprivate lazy var listSong = [Song]()
    
    fileprivate lazy var favoriteCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Dimension.shared.mediumMargin
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerReusableCell(FavoriteCollectionViewCell.self)
        collectionView.registerReusableSupplementaryView(FavoriteHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutFavoriteCollectionView()
    }
    
    private func layoutFavoriteCollectionView() {
        view.addSubview(favoriteCollectionView)
        favoriteCollectionView.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom)
            }
            make.left.equalToSuperview().offset(Dimension.shared.normalMargin)
            make.right.equalToSuperview().offset(-Dimension.shared.normalMargin)
            make.bottom.equalToSuperview()
        }
    }
    
    public func configData(songs: [Song]) {
        self.listSong = songs
    }
    
}

// MARK: - UICollectionViewDelegate

extension PlayListViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource

extension PlayListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listSong.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FavoriteCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.layer.cornerRadius = 10
        cell.configCell(song: listSong[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: FavoriteHeaderCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath)
        return header
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PlayListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 65)
    }
}
