//
//  DetailViewPlaySong.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/1/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit
import AVFoundation

class DetailViewPlaySong: BaseView {
    
    fileprivate var currentSong: SongTrack?
    fileprivate var isSelctSlider: Bool = false
    
    private let backGroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "artwork")
        imageView.makeVisualEffect()
        return imageView
    }()
    
    fileprivate lazy var thumnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "artwork")
        return imageView
    }()
        
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        let pangesture = UIPanGestureRecognizer(target: self, action: #selector(fakePanGesture))
        view.addGestureRecognizer(pangesture)
        return view
    }()
    
    fileprivate lazy var songTrackLabel: UILabel = {
        let label = UILabel()
        label.text = "Mãi không rời xa"
        label.font = UIFont.systemFont(ofSize: FontSize.headline.rawValue, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    fileprivate lazy var artistTrackLabel: UILabel = {
        let label = UILabel()
        label.text = "Sơn tùng - MTP"
        label.font = UIFont.systemFont(ofSize: FontSize.body.rawValue, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()

    private let saveSongButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageManager.like?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.layer.masksToBounds = true
        return button
    }()

    fileprivate let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "0:03"
        label.font = UIFont.systemFont(ofSize: FontSize.h2.rawValue)
        return label
    }()
    
    private let timeIntervalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "3:49"
        label.font = UIFont.systemFont(ofSize: FontSize.h2.rawValue)
        return label
    }()
    
    fileprivate let timeSlider: UISlider = {
        let slider = UISlider()
        slider.tintColor = UIColor.spotifyGreen
        slider.setThumbImage(IConPlaySongVC.thumbImage.image, for: .normal)
        return slider
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setImage(IConPlaySongVC.playIcon.image, for: .normal)
        button.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let shuffleButton: UIButton = {
        let button = UIButton()
        button.setImage(IConPlaySongVC.shuffleIcon.image, for: .normal)
        return button
    }()
    
    private let repeatButton: UIButton = {
        let button = UIButton()
        button.setImage(IConPlaySongVC.repeatIcon.image, for: .normal)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setImage(IConPlaySongVC.nextIcon.image, for: .normal)
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(IConPlaySongVC.backIcon.image, for: .normal)
        return button
    }()
    
    private let deviceButton: UIButton = {
        let button = UIButton()
        button.setImage(IConPlaySongVC.deviceIcon.image, for: .normal)
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(IConPlaySongVC.shareIcon.image, for: .normal)
        return button
    }()
    
    
    // MARK: - View LifeCycles
    
    override func initialize() {
        super.initialize()
        layoutBackgroundImage()
        layoutThumnailImageView()
        layoutViewBackgroundView()
        layoutSongTrackStackView()
        layoutSaveSongButton()
        layoutTimeSlider()
        layoutCurrentTimeLabel()
        layoutTimeIntervalLabel()
        layoutShuffleButton()
        layoutRepeatButton()
        layoutPlayButton()
        layoutNextButton()
        layoutBackButton()
        layoutDeviceButton()
        layoutShareButton()
    }
    
    //MARK: - UI Action
    
    @objc func playButtonPressed() {
        MusicPlayer.shared.pause()
        checkShowImagePlayIcon()
    }
    
    fileprivate func checkShowImagePlayIcon() {
        if MusicPlayer.shared.isPlaying {
            self.playButton.setImage(IConPlaySongVC.playIcon.image, for: .normal)
        } else {
            self.playButton.setImage(IConPlaySongVC.pauseIcon.image, for: .normal)
        }
    }
    
    @objc func fakePanGesture() {
        
    }

    //MARK: - Layout
    
    private func layoutBackgroundImage() {
        addSubview(backGroundImage)
        backGroundImage.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func layoutThumnailImageView() {
        addSubview(thumnailImageView)
        thumnailImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(Dimension.shared.largeMargin)
            make.right.equalToSuperview().offset(-Dimension.shared.largeMargin)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(4 * Dimension.shared.normalMargin)
        }
    }
    
    private func layoutViewBackgroundView() {
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.equalTo(thumnailImageView.snp.bottom).offset(Dimension.shared.normalMargin)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func layoutSongTrackStackView() {
        let stackView = makeStackView(axis: .vertical)
        stackView.spacing = 6
        stackView.addArrangedSubview(songTrackLabel)
        stackView.addArrangedSubview(artistTrackLabel)
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(thumnailImageView.snp.bottom).offset(Dimension.shared.largeMargin_50)
            make.left.equalToSuperview().offset(Dimension.shared.normalMargin)
            make.right.equalToSuperview().offset(-Dimension.shared.largeMargin_90)
        }
    }
    
    private func layoutSaveSongButton() {
        addSubview(saveSongButton)
        saveSongButton.snp.makeConstraints { (make) in
            make.top.equalTo(thumnailImageView.snp.bottom).offset(Dimension.shared.largeMargin_50 + 24)
            make.right.equalToSuperview().offset(-Dimension.shared.largeMargin)
            make.width.height.equalTo(24)
        }
    }
    
    private func layoutTimeSlider() {
        addSubview(timeSlider)
        timeSlider.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.7)
            make.centerX.equalToSuperview()
            make.top.equalTo(saveSongButton.snp.bottom).offset(Dimension.shared.largeMargin_25)
        }
    }
    
    private func layoutCurrentTimeLabel() {
        addSubview(currentTimeLabel)
        currentTimeLabel.snp.makeConstraints { (make) in
            make.width.equalTo(40 * Dimension.shared.widthScale)
            make.left.equalTo(thumnailImageView)
            make.centerY.equalTo(timeSlider)
        }
    }
    
    private func layoutTimeIntervalLabel() {
        addSubview(timeIntervalLabel)
        timeIntervalLabel.snp.makeConstraints { (make) in
            make.width.equalTo(currentTimeLabel)
            make.right.equalTo(thumnailImageView)
            make.centerY.equalTo(timeSlider)
        }
    }
    
    private func layoutShuffleButton() {
        addSubview(shuffleButton)
        shuffleButton.snp.makeConstraints { (make) in
            make.left.equalTo(thumnailImageView)
            make.width.height.equalTo(30)
            make.top.equalTo(timeSlider.snp.bottom).offset(Dimension.shared.largeMargin_25  + 5)
        }
    }
    
    private func layoutRepeatButton() {
        addSubview(repeatButton)
        repeatButton.snp.makeConstraints { (make) in
            make.right.equalTo(thumnailImageView)
            make.width.height.equalTo(30)
            make.top.equalTo(timeSlider.snp.bottom).offset(Dimension.shared.largeMargin_25  + 5)
        }
    }
    
    private func layoutPlayButton() {
        addSubview(playButton)
        playButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(65)
            make.centerY.equalTo(shuffleButton)
        }
    }
    
    private func layoutNextButton() {
        addSubview(nextButton)
        nextButton.snp.makeConstraints { (make) in
            make.right.equalTo(repeatButton.snp.left).offset(-45)
            make.height.width.equalTo(35)
            make.centerY.equalTo(shuffleButton)
        }
    }
    
    private func layoutBackButton() {
        addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.left.equalTo(shuffleButton.snp.right).offset(45)
            make.height.width.equalTo(35)
            make.centerY.equalTo(shuffleButton)
        }
    }
    
    private func layoutDeviceButton() {
        addSubview(deviceButton)
        deviceButton.snp.makeConstraints { (make) in
            make.top.equalTo(shuffleButton.snp.bottom).offset(Dimension.shared.largeMargin_25 + 15)
            make.height.width.equalTo(shuffleButton)
            make.left.equalTo(thumnailImageView)
        }
    }
    
    private func layoutShareButton() {
        addSubview(shareButton)
        shareButton.snp.makeConstraints { (make) in
            make.top.equalTo(deviceButton)
            make.height.width.equalTo(25)
            make.right.equalTo(thumnailImageView)
        }
    }
    
}
