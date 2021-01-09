//
//  InfomationPlaySongCell.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/1/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class InfomationPlaySongCell: BaseTableViewCell {
    
    var song: SongTrack? {
        didSet {
            self.nameOfSongLabel.text = self.song?.title
            self.displayNameLabel.text = self.song?.artist_id
            self.checkShowOrHideIndicatorView()
        }
    }
    // MARK: - UI Elements
    
    private let ordinalLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: FontSize.h1.rawValue)
        return label
    }()
    
    private let nameOfSongLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: FontSize.h1.rawValue, weight: .bold)
        label.textColor = UIColor.white
        label.textAlignment = .left
        return label
    }()
    
    private let displayNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: FontSize.h1.rawValue)
        return label
    }()
    
    fileprivate var indicatorView = NVActivityIndicatorView(frame: .zero)
    
    // MARK: - ViewLife
    
    override func initialize() {
        super.initialize()
        layoutOrdinalLabel()
        layoutNameOfSongLabel()
        layoutDisplayNameLabel()
        setupViewIndicatorView()
    }
    
    //MARK: Public function
    func setOrdinalNumber(index: Int) {
        self.ordinalLabel.text = "\(index + 1)"
    }
    
    //MARK: Feature function
    func checkShowOrHideIndicatorView() {
        if !MusicPlayer.shared.isPlaying {
            self.indicatorView.isHidden = true
            return
        }
        
        if self.song?.id == MusicPlayer.shared.curentSong?.id {
            self.indicatorView.isHidden = false
        } else {
            self.indicatorView.isHidden = true
        }
    }
    // MARK: - Layout
    
    private func layoutOrdinalLabel() {
        addSubview(ordinalLabel)
        ordinalLabel.snp.makeConstraints { (make) in
            make.width.equalTo(22 * Dimension.shared.widthScale)
            make.left.equalToSuperview().offset(1.5 * Dimension.shared.normalMargin)
            make.top.equalToSuperview().offset(1.5 * Dimension.shared.normalMargin)
        }
    }
    
    private func layoutNameOfSongLabel() {
        addSubview(nameOfSongLabel)
        nameOfSongLabel.snp.makeConstraints { (make) in
            make.left.equalTo(ordinalLabel.snp.right).offset(Dimension.shared.normalMargin)
            make.top.equalToSuperview().offset(1.0 * Dimension.shared.normalMargin)
        }
    }
    
    private func layoutDisplayNameLabel() {
        addSubview(displayNameLabel)
        displayNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameOfSongLabel)
            make.top.equalTo(nameOfSongLabel.snp.bottom)
            make.bottom.equalToSuperview().offset(-Dimension.shared.normalMargin / 2)
        }
    }
    
    private func setupViewIndicatorView() {
        self.indicatorView.isHidden = true
        let type = NVActivityIndicatorType.audioEqualizer
        let color = UIColor.white
        let frameIndicatorView = CGRect(x: UIScreen.main.bounds.width - 3 * Dimension.shared.normalMargin,
                                        y: Dimension.shared.normalMargin,
                                        width: 30,
                                        height: 20)
        self.indicatorView = NVActivityIndicatorView(frame: frameIndicatorView, type: type, color: color, padding: 1)
        self.addSubview(self.indicatorView)
        self.indicatorView.startAnimating()
    }
    
}
