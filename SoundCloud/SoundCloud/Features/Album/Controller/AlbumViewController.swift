//
//  AlbumViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/22/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class AlbumViewController: BaseViewController {
    
    // MARK - Variables
    
    var song: [Song] = []
    var album = PlayList()
    var idAlbum = ""
    
    // MARK: - UI ELemenets
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = UIColor.background
        control.addTarget(self, action: #selector(requestAPIGetPlistSong), for: .valueChanged)
        return control
    }()

    fileprivate lazy var albumCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Dimension.shared.normalMargin
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerReusableCell(SongCollectionViewCell.self)
        collectionView.registerReusableSupplementaryView(HeaderViewCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
        return collectionView
    }()
    
    // MARK: - View LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutViewPlaySong()
        layoutViewDetailPlaySong()
        layoutAlbumCollectionView()
        requestAPIGetPlistSong()
    }
    
    //MARK: Initialize function
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewPlaySong.isHidden = false
        self.detailViewPlaySong.isHidden = false
    }
    // MARK: - API
    
    @objc private func requestAPIGetPlistSong() {
        let endPoint = SongEndPoint.getPlistSongById(param: ["albumID": idAlbum])
        self.showLoading()
        APIService.request(endPoint: endPoint, onSuccess: { [weak self](apiResponse) in
            self?.song = apiResponse.toArray([Song.self])
            MusicPlayer.shared.yourPlayListSong = self?.song
            self?.reloadDataWhenFinishLoadAPI()
        }, onFailure: { (apiError) in
            self.reloadDataWhenFinishLoadAPI()
            print("error")
        }) {
            print("error")
        }
    }
    
    private func reloadDataWhenFinishLoadAPI() {
        self.hideLoading()
        self.isRequestingAPI = false
        self.albumCollectionView.reloadData()
        self.refreshControl.endRefreshing()
        
    }
    
    // MARK: - UI Action
    
    
    fileprivate func animationScrollUpPlaySongView() {
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveLinear, animations: {
            self.viewPlaySong.frame.origin = CGPoint(x: 0,
                                                     y: UIScreen.main.bounds.height - Dimension.shared.heightViewPlayMusic - self.tabBarController!.tabBar.frame.height)
            
        }) { (finish) in
            self.albumCollectionView.contentInset = UIEdgeInsets(top: 0,
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
    
    // MARK: - Helper Method
    
    // MARK: - Layout
    
    private func layoutAlbumCollectionView() {
        view.addSubview(albumCollectionView)
        albumCollectionView.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom)
            }
            make.left.right.bottom.equalToSuperview()
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

// MARK: - UICollectionViewDelegateFlowLayout

extension AlbumViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 360)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}

// MARK: - UICollectionViewDelegate

extension AlbumViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let songTrack = song[indexPath.row]
        self.viewPlaySong.setData(song: songTrack)
        MusicPlayer.shared.play(newSong: songTrack) {
            self.detailViewPlaySong.setData()
            self.detailViewPlaySong.setViewPlaySong(viewPlay: viewPlaySong)
        } onError: {
        
        }
        self.animationScrollUpPlaySongView()
    }
}

// MARK: - UICollectionViewDelegate

extension AlbumViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return song.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SongCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configCell(song: song[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: HeaderViewCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath)
        header.configCell(album: album)
        return header
    }
    
}


