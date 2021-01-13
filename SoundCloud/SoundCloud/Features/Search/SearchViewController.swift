//
//  SearchViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 9/25/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit


class SearchViewController: BaseViewController {
    
    // MARK: - Variables
    
    fileprivate lazy var imageModel: [String] = ["type1", "type2", "type3", "type4", "type5", "type6", "type7", "type8", "type5", "type6", "type7", "type8"]
    
    // MARK: - UI Elemenets
    
    private lazy var searchTextField: PaddingTextField = {
        let textField = PaddingTextField()
        textField.placeholder = TextManager.songPlayerHoler
        textField.leftImage = ImageManager.searchPlayer
        textField.rightImage = ImageManager.mic
        textField.backgroundColor = UIColor.white
        textField.layer.cornerRadius = Dimension.shared.defaultHeightTextField / 2
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1.0
        textField.returnKeyType = .search
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        textField.layer.borderColor = UIColor.lightSeparator.cgColor
        textField.addTarget(self, action: #selector(touchInSearchSongBar), for: .editingDidBegin)
        return textField
    }()
    
    fileprivate lazy var searchCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.registerReusableCell(SearchPlayerCollectionViewCell.self)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // MARK: - View LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = TextManager.search
        layoutSearchTextField()
        layoutSearchCollectionView()
    }
    
    // MARK: - UI Action
    
    @objc func touchInSearchSongBar() {
        let vc = SearchSongViewController()
        let navController = UINavigationController(rootViewController: vc)
        self.navigationController?.present(navController, animated: true, completion: nil)
        searchTextField.endEditing(true)
    }
    
    // MARK: - Layout
    
    private func layoutSearchTextField() {
        view.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Dimension.shared.mediumMargin)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom).offset(Dimension.shared.mediumMargin)
            }
            make.right.equalToSuperview().offset(-Dimension.shared.normalMargin)
            make.left.equalToSuperview().offset(Dimension.shared.normalMargin)
            make.height.equalTo(Dimension.shared.defaultHeightTextField)
        }
    }
    
    private func layoutSearchCollectionView() {
        view.addSubview(searchCollectionView)
        searchCollectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(Dimension.shared.normalMargin)
            make.right.equalToSuperview().offset(-Dimension.shared.normalMargin)
            if #available(iOS 11, *) {
                make.bottom.equalTo(view.snp_bottomMargin)
            } else {
                make.bottom.equalTo(bottomLayoutGuide.snp.top)
            }
            make.top.equalTo(searchTextField.snp.bottom).offset(Dimension.shared.largeMargin)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 16) / 2
        return CGSize(width: width, height: 125)
    }
}

// MARK: - UICollectionViewDataSource

extension SearchViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SearchPlayerCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configCell(songImage: UIImage(named: imageModel[indexPath.row]))
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

