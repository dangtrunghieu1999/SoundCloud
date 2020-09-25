//
//  ViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 9/23/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Helper Type
    
    enum HomeCategory: Int {
        case hotNow             = 0
        case mood               = 1
        case popular            = 2
        
        static func numberOfSections() -> Int {
            return 3
        }
        
        var title: String {
            switch self {
            case .hotNow:
                return TextManager.hotNow
            case .mood:
                return TextManager.mood
            case .popular:
                return TextManager.popular_artist
            }
        }
        var color: UIColor {
            switch self {
            case .hotNow:
                return UIColor.background
            default:
                return UIColor.titleText
            }
        }
        
        var font: UIFont {
            switch self {
            case .hotNow:
                return UIFont.systemFont(ofSize: FontSize.headline.rawValue)
            default:
                return UIFont.systemFont(ofSize: FontSize.mediumLine.rawValue)
            }
        }
    }
    
    // MARK: - Variables
    
    
    // MARK: - UI Elements
    
    private lazy var homeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.registerReusableCell(HotNowCollectionViewCell.self)
        collectionView.registerReusableCell(MoodCollectionViewCell.self)
        collectionView.registerReusableCell(ArtistCollectionViewCell.self)
        collectionView.registerReusableSupplementaryView(HomeCollectionViewHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
        return collectionView
    }()
    
    // MARK: - View LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutHomeCollectionView()
        
    }
    
    // MARK:- Helper Method
    
    // MARK: - UI Actions
    
    // MARK: - Public Method
    
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

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let homeType = HomeCategory(rawValue: indexPath.section)
        if homeType == .popular {
            return CGSize(width: collectionView.frame.width, height: 200)
        } else {
            return CGSize(width: collectionView.frame.width, height: 230)
        }
    }
    
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource  {
    
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
        case .hotNow:
            let cell: HotNowCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .mood:
            let cell: MoodCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .popular:
            let cell: ArtistCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
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
