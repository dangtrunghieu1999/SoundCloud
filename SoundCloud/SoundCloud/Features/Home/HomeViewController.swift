//
//  ViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 9/23/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    // MARK:- Help Type
    
    enum HomeCategory: Int {
        case timeline           = 0
        case recently           = 1
        case madeyou            = 2
        
        static func numberOfSections() -> Int {
            return 3
        }
        
        var title: String {
            switch self {
            case .timeline:
                return TextManager.timeline
            case .recently:
                return TextManager.recently
            case .madeyou:
                return TextManager.madeyou
            }
        }
        var color: UIColor {
            return UIColor.white
        }
        
        var font: UIFont {
            return UIFont.systemFont(ofSize: FontSize.headline.rawValue, weight: .bold)
        }
    }
    
    // MARK: - UI Elements
    
    private lazy var homeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.registerReusableCell(TimeLineCollectionViewCell.self)
        collectionView.registerReusableCell(RecentlyPlayedCollectionViewCell.self)
        collectionView.registerReusableCell(MadeForYouCollectionViewCell.self)
        collectionView.registerReusableSupplementaryView(HomeCollectionViewHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
        return collectionView
    }()
    
    
    // MARK: - View LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setRightNavigationBar(ImageManager.setting)
        layoutHomeCollectionView()
    }
    
    // MARK: - Layouts
    
    private func layoutHomeCollectionView() {
        view.addSubview(homeCollectionView)
        homeCollectionView.snp.makeConstraints { (make) in
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

extension HomeViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return HomeCategory.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let homeType = HomeCategory(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }
        switch homeType {
        case .timeline:
            let cell: TimeLineCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .recently:
            let cell: RecentlyPlayedCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .madeyou:
            let cell: MadeForYouCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header: HomeCollectionViewHeaderCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath)
        
        header.titleName  = HomeCategory(rawValue: indexPath.section)?.title
        header.titleColor = HomeCategory(rawValue: indexPath.section)?.color
        header.fontSize   = HomeCategory(rawValue: indexPath.section)?.font
        return header
    }
}

// MARK: - UICollectionViewFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let homeType = HomeCategory(rawValue: indexPath.section)
        if homeType == .timeline {
            return CGSize(width: collectionView.frame.width, height: 220)
        } else {
            return CGSize(width: collectionView.frame.width, height: 200)
        }
    }
}
