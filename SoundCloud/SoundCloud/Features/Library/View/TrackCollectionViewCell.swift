//
//  TrackCollectionViewCell.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/21/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class TrackCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Variables
    
    var track: Track? {
        didSet {
            guard let track = track else { return }
            let image = UIImage(named: track.imageName) ?? UIImage(named: "placeholder")!
            
            trackImageView.image  = image
            trackTitleLabel.text  = track.title
            artistTitleLabel.text = track.artist
        }
    }
    
    // MARK: - UI Elements
    
    fileprivate lazy var trackImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate lazy var trackTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.preferredFont(forTextStyle: .body).withTraits(traits: .traitBold)
        label.textAlignment = .left
        return label
    }()
    
    fileprivate lazy var artistTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.alpha = 0.7
        return label
    }()
    
    
    // MARK: - View LifeCycle
    
    override func initialize() {
        super.initialize()
        layoutTrackImageView()
        layoutStackView()
    }
    
    // MARK: - Layout
    
    private func layoutTrackImageView() {
        addSubview(trackImageView)
        trackImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.width.height.equalTo(72)
            make.left.equalToSuperview().offset(Dimension.shared.normalMargin)
        }
    }

    private func layoutStackView() {
        let stackView = makeStackView(axis: .vertical)
        stackView.spacing = 6
        stackView.addArrangedSubview(trackTitleLabel)
        stackView.addArrangedSubview(artistTitleLabel)
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(trackImageView.snp.right).offset(Dimension.shared.mediumMargin)
            make.right.equalToSuperview().offset(-Dimension.shared.normalMargin)
        }
    }
}
