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
    
    var sections = [SectionTitle]()
    
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
        return collectionView
    }()
    
    // MARK: - View LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setRightNavigationBar(ImageManager.setting)
        fetchJson()
        layoutHomeCollectionView()
    }
    
    // MARK: - Fetch Data
    
    func fetchJson (){
        print("attempt to fetch Json")
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [ Any] {
                    // do stuff
                    jsonResult.forEach { (item) in
                        
                        let section = SectionTitle(dictionary: item as! [String : Any])
                        // print("FEtching",section.playlists)
                        self.sections.append(section)
                    }
                    self.homeCollectionView.reloadData()
                }
            } catch {
                // handle error
            }
        }
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TabCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.sectionTitle = sections[indexPath.row]
        return cell
    }
}

// MARK: - UICollectionViewFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 220)
    }
}
