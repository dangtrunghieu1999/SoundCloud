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
    
    fileprivate lazy var song = [SongTrack]()
    
    // MARK: - UI Elements
    
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
        tableView.showsVerticalScrollIndicator = false
        tableView.registerReusableCell(LibraryTableViewCell.self)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = TextManager.music
        layoutLibraryTableView()
        checkView()
    }
    
    // MARK: - Layout
    
    private func checkView() {
        if song.count > 0 {
            layoutLibraryTableView()
        } else {
            layoutPlayListEmpty()
        }
    }
    
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

extension YourLibraryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("aaa")
    }
}

extension YourLibraryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LibraryTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        return cell
    }
    
}

extension YourLibraryViewController: EmptyPlayListSongView {
    func tapOnCreatePlayList() {
        let vc = YourPlayListViewController()
        let navController = UINavigationController(rootViewController: vc)
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
}
