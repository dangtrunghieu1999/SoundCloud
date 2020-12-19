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
    
    fileprivate lazy var searchTitleModel: [String] = ["Dance","Hiphop","Edm"]
    fileprivate lazy var imageModel: [String] = ["type1", "type2", "type3", "type4", "type5", "type6"]

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
        textField.layer.borderColor = UIColor.lightSeparator.cgColor
        return textField
    }()
    
    fileprivate lazy var searchCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.registerReusableCell(SearchPlayerCollectionViewCell.self)
        collectionView.registerReusableSupplementaryView(HomeCollectionViewHeaderCell.self,
                                                         forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    
    
    // MARK: - View LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search"
        layoutSearchTextField()
        layoutSearchCollectionView()
    }
    
    // MARK: - UI Action
    
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
            make.bottom.equalToSuperview().offset(-Dimension.shared.largeMargin_50)
            make.top.equalTo(searchTextField.snp.bottom).offset(Dimension.shared.largeMargin)
        }
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 16) / 2
        return CGSize(width: width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 20)
    }
}


extension SearchViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SearchPlayerCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configCell(songImage: UIImage(named: imageModel[indexPath.section]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header: HomeCollectionViewHeaderCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                                                   for: indexPath)
            header.configDataHeader(name: searchTitleModel[indexPath.section])
            header.titleColor = UIColor.white
            header.fontSize = UIFont.systemFont(ofSize: FontSize.h2.rawValue, weight: .bold)
        
        return header
    }
}

