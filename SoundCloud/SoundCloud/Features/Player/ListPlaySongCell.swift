//
//  ListPlaySongCell.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/1/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit


class ListPlaySongCell: BaseCollectionViewCell, BaseDetailSongMusic {

    fileprivate var arrSong: [SongTrack]?
    
    fileprivate lazy var listSongTableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.registerReusableCell(InfomationPlaySongCell.self)
        return tableView
    }()
    
    override func initialize() {
        super.initialize()
        layoutListSongTableView()
    }
    
    //MARK: Public function
    func setData(data: Any?) {
        self.arrSong = MusicPlayer.shared.playListSong
        self.listSongTableView.reloadData()
    }
    
    func setDelegate(delegate: Any?) {
        
    }

    //MARK: - Layout
    
    private func layoutListSongTableView() {
        addSubview(self.listSongTableView)
        listSongTableView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ListPlaySongCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrSong?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: InfomationPlaySongCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setOrdinalNumber(index: indexPath.item)
        cell.song = self.arrSong?[indexPath.item]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let newSong = self.arrSong?[indexPath.item] else { return }
        
        MusicPlayer.shared.play(newSong: newSong, onSuccess: {
            //Success
        }) {
            //Error
        }
    }
}

