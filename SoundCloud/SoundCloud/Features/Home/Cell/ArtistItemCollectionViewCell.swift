//
//  ArtistItemCollectionViewCell.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 9/23/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class ArtistItemCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Variables
    
    // MARK: - UI Elements
    
    fileprivate lazy var artistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    fileprivate lazy var nameArtistLabel: UILabel = {
        let label = UILabel()
        label.text = "Justin Bieber"
        label.textColor = UIColor.titleText
        label.font = UIFont.systemFont(ofSize: FontSize.h1.rawValue)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - View LifeCycles
    
    override func initialize() {
        super.initialize()
        layoutArtistImageView()
        layoutNameArtistLabel()

    }
    
    // MARK:- Helper Method
    
    public func configCell(image: UIImage?) {
        artistImageView.image = image
    }
    
    // MARK: - UI Actions
    
    // MARK: - Public Method
    
    // MARK: - Layouts
    
    private func layoutArtistImageView() {
        addSubview(artistImageView)
        artistImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(100)
        }
    }
    
    private func layoutNameArtistLabel() {
        addSubview(nameArtistLabel)
        nameArtistLabel.snp.makeConstraints { (make) in
            make.top.equalTo(artistImageView.snp.bottom).offset(5)
            make.centerX.equalTo(artistImageView)
        }
    }
    
}

