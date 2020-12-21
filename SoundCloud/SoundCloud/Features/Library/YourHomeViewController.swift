//
//  YourHomeViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/21/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class YourHomeViewController: BaseViewController {
    
    // MARK: - Variables
    
    let menuBar = MenuBar()
    let music: [[Track]] = [playlists, artists, albums]
    let colors: [UIColor] = [.systemRed, .systemBlue, .systemTeal]
    
    // MARK: - UI Elements
    
    fileprivate lazy var yourHomeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.registerReusableCell(PlaylistCollectionViewCell.self)
        return collectionView
    }()
    
    // MARK: - View LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutMenuBar()
        layoutYourHomeCollectionView()
    }
    
    // MARK: - Layouts
    
    private func layoutMenuBar() {
        view.addSubview(menuBar)
        menuBar.snp.makeConstraints { (make) in
            make.height.equalTo(42)
            make.left.right.equalToSuperview()
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaInsets)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom)
            }
        }
    }
    
    private func layoutYourHomeCollectionView() {
        view.addSubview(yourHomeCollectionView)
        yourHomeCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(menuBar.snp.bottom).offset(Dimension.shared.mediumMargin)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

extension YourHomeViewController: UICollectionViewDelegateFlowLayout {
    
}

extension YourHomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return music.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PlaylistCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.backgroundColor = colors[indexPath.item]
        cell.tracks = music[indexPath.item]
        return cell
    }
}
