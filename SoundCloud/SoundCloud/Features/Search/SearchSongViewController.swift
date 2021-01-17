//
//  SearchSongViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/12/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit

class SearchSongViewController: BaseViewController {
    
    // MARK: - Variables
    
    fileprivate lazy var songSeach = [SongTrack]()
    
    // MARK: - UI Elements
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = UIColor.background
        control.addTarget(self, action: #selector(searchBarValueChange(_:)), for: .valueChanged)
        return control
    }()
    
    fileprivate lazy var searchCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Dimension.shared.normalMargin
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.refreshControl = refreshControl
        collectionView.registerReusableCell(SongCollectionViewCell.self)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        layoutSearchCollectionView()
    }
    
    // MARK: - Setup NavBar
    
    private func setupNavBar() {
        navigationItem.titleView = searchBar
        self.setRightNavigationBar(ImageManager.cancel)
        searchBar.becomeFirstResponder()
        view.endEditing(true)
    }
    
    // MARK: - UI Action
    
    override func touchUpInRightBarButtonItem() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func searchBarValueChange(_ textField: UITextField) {
        guard let textSearch = searchBar.text else { return }
        let params = ["q": textSearch]
        let endPoint = SongEndPoint.getSearchSong(param: params)
        showLoading()
        APIService.request(endPoint: endPoint) { (apiResponse) in
            self.songSeach = apiResponse.toArray([SongTrack.self])
            self.reloadDataWhenFinishLoadAPI()
        } onFailure: { (serviceErrorAPI) in
            self.reloadDataWhenFinishLoadAPI()
        } onRequestFail: {
            
        }
    }
    
    // MARK: - API
    
    private func reloadDataWhenFinishLoadAPI() {
        self.hideLoading()
        self.isRequestingAPI = false
        self.searchCollectionView.reloadData()
        self.refreshControl.endRefreshing()
    }

    // MARK: - Layout
    
    private func layoutSearchCollectionView() {
        view.addSubview(searchCollectionView)
        searchCollectionView.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom)
            }
            make.left.right.bottom.equalToSuperview()
        }
    }
    
}

// MARK: - UICollectionViewDelegate

extension SearchSongViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource

extension SearchSongViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songSeach.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SongCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configCell(song: songSeach[indexPath.row])
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SearchSongViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}


