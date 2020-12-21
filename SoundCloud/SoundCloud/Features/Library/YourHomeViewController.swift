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
    
    let music: [[Track]] = [playlists, artists, albums]
    
    // MARK: - UI Elements
    
    fileprivate lazy var menuBar: MenuBar = {
        let menuBar = MenuBar()
        menuBar.delegate = self
        return menuBar
    }()
    
    fileprivate lazy var yourHomeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
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
            make.left.right.equalToSuperview()
            if #available(iOS 11, *) {
                make.bottom.equalTo(view.snp_bottomMargin).offset(-Dimension.shared.normalMargin)
            } else {
                make.bottom.equalTo(bottomLayoutGuide.snp.top).offset(-Dimension.shared.normalMargin)
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension YourHomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.scrollIndicator(to: scrollView.contentOffset)
    }
}

// MARK: - UICollectionViewDataSource

extension YourHomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return music.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PlaylistCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.tracks = music[indexPath.item]
        return cell
    }
}

// MARK: - MenuBarDelegate

extension YourHomeViewController: MenuBarDelegate {
    func didSelectItemAt(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        yourHomeCollectionView.scrollToItem(at: indexPath, at: [], animated: true)
    }
}
