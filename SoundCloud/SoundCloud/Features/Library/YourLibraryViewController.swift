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
    
    fileprivate lazy var song = [Song]()
    fileprivate lazy var playListName = [String]()
    fileprivate lazy var likeSong = [Song]()
    
    // MARK: - UI Elements
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = UIColor.background
        control.addTarget(self, action: #selector(getAPIFavoriteSongMe), for: .valueChanged)
        return control
    }()

    fileprivate lazy var emptyPlayList: EmptyPlayListSong = {
        let view = EmptyPlayListSong()
        view.delegate = self
        view.backgroundColor = UIColor.mainBackground
        return view
    }()
    
    fileprivate lazy var libraryTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.refreshControl = refreshControl
        tableView.showsVerticalScrollIndicator = false
        tableView.registerReusableCell(LibraryTableViewCell.self)
        tableView.registerReusableHeaderFooter(CreateYourLibraryTableView.self)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = TextManager.music
        layoutLibraryTableView()
        getAPIFavoriteSongMe()
    }
    
    // MARK: - Get API
    
    @objc private func getAPIFavoriteSongMe() {
        let endPoint = SongEndPoint.getFavoriteSong
        showLoading()
        APIService.request(endPoint: endPoint) { (apiResponse) in
            self.likeSong = apiResponse.toArray([Song.self])
            self.checkView()
            self.reloadDataWhenFinishLoadAPI()
        } onFailure: { (serviceError) in
            
        } onRequestFail: {
            
        }
    }
    
    private func checkView() {
        if playListName.count > 0 || likeSong.count > 0{
            layoutLibraryTableView()
        } else {
            layoutPlayListEmpty()
        }
    }
    
    private func reloadDataWhenFinishLoadAPI() {
        self.hideLoading()
        self.isRequestingAPI = false
        self.libraryTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    // MARK: - Layout
    
    private func layoutPlayListEmpty() {
        view.addSubview(emptyPlayList)
        emptyPlayList.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom)
            }
            make.left.equalToSuperview().offset(Dimension.shared.normalMargin)
            make.right.equalToSuperview().offset(-Dimension.shared.normalMargin)
            make.bottom.equalToSuperview().offset(-Dimension.shared.largeMargin_25)
        }
    }
    
    private func layoutLibraryTableView() {
        view.addSubview(libraryTableView)
        libraryTableView.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom)
            }
            make.left.equalToSuperview().offset(Dimension.shared.normalMargin)
            make.right.equalToSuperview().offset(-Dimension.shared.normalMargin)
            make.bottom.equalToSuperview().offset(-Dimension.shared.largeMargin_25)
        }
    }
}

// MARK: - UITableViewDelegate

extension YourLibraryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if playListName.count > 0 || likeSong.count > 0{
            return 100
        } else {
            return 300
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let vc = LikeSongViewController()
            vc.configData(likeSongs: likeSong)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            
        }
    }
    
}

// MARK: - UITableViewDataSource

extension YourLibraryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 && likeSong.count > 0{
            return 1
        } else {
            return playListName.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LibraryTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        if likeSong.count > 0 {
            cell.configLikeSong(image: ImageManager.favorites,
                                title: TextManager.favorites,
                                description: "\(likeSong.count) \(TextManager.song)")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: CreateYourLibraryTableView = tableView.dequeueReusableHeaderFooterView()
        header.delegate = self
        return header
    }
}

// MARK: - EmptyPlayListSongView

extension YourLibraryViewController: EmptyPlayListSongView {
    func tapOnCreatePlayList() {
        let vc = CreateYourPlayListViewController()
        let navController = UINavigationController(rootViewController: vc)
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
}

