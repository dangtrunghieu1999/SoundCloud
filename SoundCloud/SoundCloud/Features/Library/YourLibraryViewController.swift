//
//  YourHomeViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/21/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class YourLibraryViewController: BaseViewController {
    
    // MARK: - Variables
    
    enum YourSection: Int {
        case craete          = 0
        case favorite        = 1
        case playList        = 2
        
        static func numberOfSection() -> Int {
            return 3
        }
    }
    
    fileprivate lazy var song = [Song]()
    fileprivate lazy var playList = [YourPlayList]()
    fileprivate lazy var likeSong = [Song]()
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = UIColor.background
        control.addTarget(self, action: #selector(getAPIFavoriteSongMe), for: .valueChanged)
        return control
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Dimension.shared.smallMargin
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.refreshControl = refreshControl
        collectionView.registerReusableCell(LibraryCollectionViewCell.self)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = TextManager.music
        layoutCollectionView()
        getAPIFavoriteSongMe()
    }
    
    @objc private func getAPIFavoriteSongMe() {
        let endPoint = SongEndPoint.getFavoriteSong
        showLoading()
        APIService.request(endPoint: endPoint) { (apiResponse) in
            self.likeSong = apiResponse.toArray([Song.self])
            self.getAPIPlayListSongMe()
        } onFailure: { (serviceError) in
            
        } onRequestFail: {
            
        }
    }
    
    @objc private func getAPIPlayListSongMe() {
        let endPoint = SongEndPoint.getPlayListSong
        APIService.request(endPoint: endPoint) { (apiResponse) in
            self.playList = apiResponse.toArray([YourPlayList.self])
            self.reloadDataWhenFinishLoadAPI()
        } onFailure: { (serviceError) in
            
        } onRequestFail: {
            
        }
    }
    
    private func reloadDataWhenFinishLoadAPI() {
        self.hideLoading()
        self.isRequestingAPI = false
        self.collectionView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    private func layoutCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide).offset(Dimension.shared.largeMargin_30)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom).offset(Dimension.shared.largeMargin_30)
            }
            make.left.equalToSuperview().offset(Dimension.shared.normalMargin)
            make.right.equalToSuperview().offset(-Dimension.shared.normalMargin)
            make.bottom.equalToSuperview().offset(-Dimension.shared.largeMargin_25)
        }
    }
}

extension YourLibraryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
}

extension YourLibraryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return YourSection.numberOfSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let yourSection = YourSection(rawValue: section)
        switch yourSection {
        case .craete:
            return 1
        case .favorite:
            return 1
        default:
            return playList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let yourSection = YourSection(rawValue: indexPath.section)
        switch yourSection {
        case .craete:
            let cell: LibraryCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configLikeSong(image: ImageManager.create, title: TextManager.create, description: nil)
            return cell
        case .favorite:
            let cell: LibraryCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configLikeSong(image: ImageManager.favorites,
                                title: TextManager.favorites,
                                description: "\(likeSong.count) \(TextManager.song)")
            return cell
        default:
            let cell: LibraryCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configCell(playList: playList[indexPath.row])
            return cell
        }
    }
}

extension YourLibraryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let yourSection = YourSection(rawValue: indexPath.section)
        switch yourSection {
        case .craete:
            let vc = CreateYourPlayListViewController()
            vc.delegate = self
            let navController = UINavigationController(rootViewController: vc)
            self.navigationController?.present(navController, animated: true, completion: nil)
        case .favorite:
            let vc = FavoriteViewController()
            vc.configData(likeSongs: likeSong)
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            let vc = PlayListViewController()
            let songs = playList[indexPath.row].listSongs
            vc.configData(songs: songs)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension YourLibraryViewController: CreateYourPlayListViewDelegate {
    func createSuccessReloadData() {
        self.showLoading()
        self.getAPIFavoriteSongMe()
        self.collectionView.reloadData()
    }
}


