//
//  TabCellCollectionViewCell.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/3/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class TabCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Variables
    
    var sectionTitle: SectionTitle? {
        didSet{
            guard let section = self.sectionTitle else {return}
            self.titleLabel.text = section.title
            
            self.sectionTitle?.playlists.forEach({ (item) in
                let playlist = PlayList(dictionary: item as! [String : Any])
                self.playlists.append(playlist)
            })
            
            self.tabCollectionView.reloadData()
        }
    }
    
    lazy var playlists = [PlayList]()
    
    // MARK: - UI Elements
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: FontSize.headline.rawValue, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var tabCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.registerReusableCell(PlayListCollectionViewCell.self)
        return collectionView
    }()
    
    
    // MARK: - View LifeCycles
    
    override func initialize() {
        super.initialize()
        layoutTitleLabel()
        layoutTabCollecionView()
    }
    
    // MARK: - Layouts
    
    private func layoutTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(Dimension.shared.normalMargin)
            make.top.equalToSuperview().offset(Dimension.shared.normalMargin)
        }
    }
    
    private func layoutTabCollecionView() {
        addSubview(tabCollectionView)
        tabCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(Dimension.shared.smallMargin)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-Dimension.shared.normalMargin)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TabCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 16 * 2 - 32) / 2.6
        let height = frame.height / 2
        return CGSize(width: width, height: height)
    }
}

// MARK: - UICollectionViewDataSource

extension TabCollectionViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PlayListCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configCell(song: playlists[indexPath.row])
        return cell
    }
}
