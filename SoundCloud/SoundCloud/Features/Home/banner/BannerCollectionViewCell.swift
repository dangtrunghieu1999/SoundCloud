//
//  BannerCollectionViewCell.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/17/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Variables
    
    var currentIndex = 0
    var timer: Timer?
    
    // MARK: - Properties
    
    fileprivate lazy var viewModel: BannerViewModel = {
        let viewModel = BannerViewModel()
        return viewModel
    }()
    
    // MARK: - UI Elements
    
    fileprivate lazy var coverView: BaseView = {
        let view = BaseView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.registerReusableCell(ImageCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    fileprivate let pageIndicator: UIPageControl = {
        let pageIndicator = UIPageControl()
        pageIndicator.numberOfPages = 5
        pageIndicator.currentPage = 0
        pageIndicator.currentPageIndicatorTintColor = UIColor.pageIndicatorTintColor
        pageIndicator.pageIndicatorTintColor = UIColor.white
        return pageIndicator
    }()
    
    // MARK: - View LifeCycles
    
    override func initialize() {
        super.initialize()
        backgroundColor = UIColor.mainBackground
        layoutCoverView()
        layoutCollectionView()
        layoutPageIndicator()
        startTimer()
    }
    
    // MARK: - Helper Method
    
    func startTimer() {
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.timeAction), userInfo: nil, repeats: true)
        }
    }
    
    @objc private func timeAction() {
        if currentIndex < 5 {
            let index = IndexPath(item: currentIndex, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            currentIndex += 1
        } else {
            currentIndex = 0
            let index = IndexPath(item: currentIndex, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        }
    }
    
    // MARK: - Layout
    
    private func layoutCoverView() {
        addSubview(coverView)
        coverView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(Dimension.shared.largeWidthButton)
            make.top.equalToSuperview()
        }
    }
    
    private func layoutCollectionView() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    private func layoutPageIndicator() {
        addSubview(pageIndicator)
        pageIndicator.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(Dimension.shared.normalMargin)
            make.width.equalTo(Dimension.shared.widthAvatarDefault)
            make.bottom.equalTo(collectionView.snp.bottom).offset(-Dimension.shared.mediumMargin)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BannerCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

// MARK: - UICollectionViewDataSource

extension BannerCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configCell(image: viewModel.image[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension BannerCollectionViewCell: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / collectionView.frame.width)
        pageIndicator.currentPage = currentPage
    }
}
