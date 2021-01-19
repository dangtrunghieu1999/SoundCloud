//
//  LikeSongViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/14/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit

class FavoriteViewController: BaseViewController {

    fileprivate lazy var likeSong = [Song]()
    
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
        layoutViewPlaySong()
        layoutViewDetailPlaySong()
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
    
    public func configData(likeSongs: [Song]) {
        self.likeSong = likeSongs
    }
    
    fileprivate func animationScrollUpPlaySongView() {
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveLinear, animations: {
            self.viewPlaySong.frame.origin = CGPoint(x: 0,
                                                     y: UIScreen.main.bounds.height - Dimension.shared.heightViewPlayMusic - self.tabBarController!.tabBar.frame.height)
            
        }) { (finish) in
            self.favoriteCollectionView.contentInset = UIEdgeInsets(top: 0,
                                                              left: 0,
                                                              bottom:  Dimension.shared.heightViewPlayMusic, right: 0)
        }
    }
    
    fileprivate func animationScrollDownPlaySongView() {
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveLinear, animations: {
            self.viewPlaySong.layer.transform = CATransform3DIdentity
        }) { (finish) in
            //Do some thing when finish animation
        }
    }
    
    private func layoutViewPlaySong() {
        self.navigationController?.view.addSubview(self.viewPlaySong)
        self.viewPlaySong.frame = CGRect(x: 0,
                                         y: UIScreen.main.bounds.height - tabBarController!.tabBar.frame.height,
                                         width: UIScreen.main.bounds.width,
                                         height: Dimension.shared.heightViewPlayMusic)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewPlaySongPanGesture(_:)))
        self.viewPlaySong.addGestureRecognizer(panGesture)
    }
    
    private func layoutViewDetailPlaySong() {
        self.navigationController?.view.addSubview(self.detailViewPlaySong)
        
        self.detailViewPlaySong.frame = CGRect(x: 0,
                                               y: UIScreen.main.bounds.height - Dimension.shared.heightTabar,
                                               width: UIScreen.main.bounds.width,
                                               height: UIScreen.main.bounds.height)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(detailViewPlaySongPanGesture(_:)))
        self.detailViewPlaySong.addGestureRecognizer(panGesture)
        
    }
    
}

// MARK: - UICollectionViewDelegate

extension FavoriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let songTrack = likeSong[indexPath.row]
        
        MusicPlayer.shared.addToPlayList(likeSong)
        MusicPlayer.shared.play(song: songTrack)
        
        self.detailViewPlaySong.setViewPlaySong(viewPlay: viewPlaySong)
        self.animationScrollUpPlaySongView()
    }
}

// MARK: - UICollectionViewDataSource

extension FavoriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likeSong.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FavoriteCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.layer.cornerRadius = 10
        cell.configCell(song: likeSong[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: FavoriteHeaderCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath)
        header.delegate = self
        return header
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 65)
    }
}

extension FavoriteViewController: HeaderViewCollectionReusableViewDelegate {
    func playRandom() {
        MusicPlayer.shared.play(with: likeSong)
        self.detailViewPlaySong.setViewPlaySong(viewPlay: viewPlaySong)
        self.animationScrollUpPlaySongView()
    }
}
