//
//  SearchViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 9/25/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {

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
//        textField.delegate = self
//        textField.addTarget(self, action: #selector(textFieldValueChange), for: .editingChanged)
//        textField.addTarget(self, action: #selector(textFieldEndEditing), for: .editingDidEnd)
//        textField.addTarget(self, action: #selector(touchInTextField), for: .editingDidBegin)
        return textField
    }()
    
    fileprivate lazy var searchCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerReusableCell(SearchPlayerCollectionViewCell.self)
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
            make.left.right.equalTo(searchTextField)
            make.top.equalTo(searchCollectionView.snp.bottom).offset(Dimension.shared.largeMargin_25)
            make.bottom.equalToSuperview()
        }
    }
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SearchPlayerCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        return cell
    }
}

