//
//  ViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 9/23/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    // MARK:- Variables
        
    var sections = [SectionHome]()
    
    // MARK: - UI Elements
    
    fileprivate lazy var homeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerReusableCell(TabCollectionViewCell.self)
        collectionView.registerReusableCell(BannerCollectionViewCell.self)
        return collectionView
    }()
    
    // MARK: - View LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setRightNavigationBar(ImageManager.setting)
        layoutHomeCollectionView()
        requestAPIGetPlistSong()
    }
    
    // MARK: - Fetch Data
    
    @objc private func requestAPIGetPlistSong() {
        let endPoint = SongEndPoint.getHomeSong
        self.showLoading()
        APIService.request(endPoint: endPoint, onSuccess: { [weak self](apiResponse) in
            self?.sections = apiResponse.toArray([SectionHome.self])
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
        self.homeCollectionView.reloadData()
    }
    
    override func touchUpInRightBarButtonItem() {
        let vc = SettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Layouts
    
    private func layoutHomeCollectionView() {
        view.addSubview(homeCollectionView)
        homeCollectionView.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide)
                make.bottom.equalTo(view.snp_bottomMargin)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom)
                make.bottom.equalTo(bottomLayoutGuide.snp.top)
            }
            make.left.right.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return sections.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell: BannerCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        } else {
            let cell: TabCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.sectionTitle = sections[indexPath.row]
            return cell
        }
    }
}

// MARK: - UICollectionViewFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: view.frame.width, height: 230)
        } else {
            return CGSize(width: view.frame.width, height: 220)
        }
    }
}
