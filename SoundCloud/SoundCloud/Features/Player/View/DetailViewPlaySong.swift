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
   
    // MARK: - Variables
    
    fileprivate var currentSong: Song?
    fileprivate var isSelctSlider: Bool = false
    fileprivate var viewPlaySong = ViewPlaySong()
    fileprivate var dishSongCell = DishSongCellCollectionViewCell()
    // MARK: - UI Elements
    
    private let backGroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.makeVisualEffect()
        return imageView
    }()
    
    fileprivate lazy var collectionViewPlaySong: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerReusableCell(DishSongCellCollectionViewCell.self)
        return collectionView
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
        label.font = UIFont.systemFont(ofSize: FontSize.h2.rawValue)
        return label
    }()
    
    private let timeIntervalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: FontSize.h2.rawValue)
        return label
    }()
    
    fileprivate let timeSlider: UISlider = {
        let slider = UISlider()
        slider.tintColor = UIColor.spotifyGreen
        slider.setThumbImage(ImageManager.thumbImage, for: .normal)
        slider.addTarget(self, action: #selector(seekSlider(_:)), for: .touchUpInside)
        slider.addTarget(self, action: #selector(didBeginSelectSlider), for: .valueChanged)
        return slider
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageManager.playIcon, for: .normal)
        button.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let shuffleButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageManager.shuffleIcon, for: .normal)
        return button
    }()
    
    private let repeatButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageManager.repeatIcon, for: .normal)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageManager.nextIcon, for: .normal)
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageManager.backIcon, for: .normal)
        return button
    }()
    
    private let deviceButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageManager.deviceIcon, for: .normal)
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageManager.shareIcon, for: .normal)
        return button
    }()
    
    
    // MARK: - View LifeCycles
    
    override func initialize() {
        super.initialize()
        layoutBackgroundImage()
        layoutCollectionViewPlaySong()
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
            self.playButton.setImage(ImageManager.playIcon, for: .normal)
            self.viewPlaySong.startAnimation()
            self.dishSongCell.startAnimation()
        } else {
            self.playButton.setImage(ImageManager.pauseIcon, for: .normal)
            self.viewPlaySong.stopAnimation()
            self.dishSongCell.stopAnimation()
        }
    }
    
    @objc func seekSlider(_ sender: UISlider) {
        self.isSelctSlider = false
        MusicPlayer.shared.seekToTime(sender.value)
    }
    
    @objc func didBeginSelectSlider() {
        self.isSelctSlider = true
    }
    
    @objc func fakePanGesture() {
        
    }
        
    public func setData() {
        self.collectionViewPlaySong.reloadData()
        self.currentSong = MusicPlayer.shared.curentSong
        
        if let song = self.currentSong {
            guard let url = URL(string: song.image) else {
                return
            }
            
            self.backGroundImage.sd_setImage(with: url)
        }
        guard let song = self.currentSong else { return }
        self.songTrackLabel.text = song.title.capitalizingFirstLetter()
        let artist = CommonMethod.convertArrayToStringText(data: song.listArtists)
        self.artistTrackLabel.text = artist
        self.setViewWhenPlaySong()
        
    }
    
    func setViewPlaySong(viewPlay: ViewPlaySong) {
        self.viewPlaySong = viewPlay
    }

    private func setViewWhenPlaySong() {
        self.checkShowImagePlayIcon()
       
        MusicPlayer.shared.getDuration { (cmTime) in
            guard let duration = cmTime else { return }
            self.timeIntervalLabel.getTimeFromCMTime(duration)
            self.timeSlider.maximumValue = Float(CMTimeGetSeconds(duration))
        }
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
    
    private func layoutCollectionViewPlaySong() {
        addSubview(collectionViewPlaySong)
        collectionViewPlaySong.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(Dimension.shared.largeMargin)
            make.right.equalToSuperview().offset(-Dimension.shared.largeMargin)
            make.height.equalToSuperview().multipliedBy(Dimension.shared.multipliedByMedium)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(4 * Dimension.shared.normalMargin)
        }
    }
    
    private func layoutViewBackgroundView() {
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.equalTo(collectionViewPlaySong.snp.bottom).offset(Dimension.shared.normalMargin)
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
            make.top.equalTo(collectionViewPlaySong.snp.bottom).offset(Dimension.shared.largeMargin_50)
            make.left.equalToSuperview().offset(Dimension.shared.normalMargin)
            make.right.equalToSuperview().offset(-Dimension.shared.largeMargin_90)
        }
    }
    
    private func layoutSaveSongButton() {
        addSubview(saveSongButton)
        saveSongButton.snp.makeConstraints { (make) in
            make.top.equalTo(collectionViewPlaySong.snp.bottom).offset(Dimension.shared.largeMargin_75)
            make.right.equalToSuperview().offset(-Dimension.shared.largeMargin)
            make.width.height.equalTo(Dimension.shared.mediumHeightButton_24)
        }
    }
    
    private func layoutTimeSlider() {
        addSubview(timeSlider)
        timeSlider.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(Dimension.shared.multipliedByDefault)
            make.centerX.equalToSuperview()
            make.top.equalTo(artistTrackLabel.snp.bottom).offset(Dimension.shared.largeMargin_25)
        }
    }
    
    private func layoutCurrentTimeLabel() {
        addSubview(currentTimeLabel)
        currentTimeLabel.snp.makeConstraints { (make) in
            make.width.equalTo(Dimension.shared.widthLabelDefault)
            make.left.equalTo(collectionViewPlaySong)
            make.centerY.equalTo(timeSlider)
        }
    }
    
    private func layoutTimeIntervalLabel() {
        addSubview(timeIntervalLabel)
        timeIntervalLabel.snp.makeConstraints { (make) in
            make.width.equalTo(currentTimeLabel)
            make.right.equalTo(collectionViewPlaySong)
            make.centerY.equalTo(timeSlider)
        }
    }
    
    private func layoutShuffleButton() {
        addSubview(shuffleButton)
        shuffleButton.snp.makeConstraints { (make) in
            make.left.equalTo(collectionViewPlaySong)
            make.width.height.equalTo(Dimension.shared.mediumHeightButton)
            make.top.equalTo(timeSlider.snp.bottom).offset(Dimension.shared.largeMargin_30)
        }
    }
    
    private func layoutRepeatButton() {
        addSubview(repeatButton)
        repeatButton.snp.makeConstraints { (make) in
            make.right.equalTo(collectionViewPlaySong)
            make.width.height.equalTo(Dimension.shared.mediumHeightButton)
            make.top.equalTo(timeSlider.snp.bottom).offset(Dimension.shared.largeMargin_30)
        }
    }
    
    private func layoutPlayButton() {
        addSubview(playButton)
        playButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(Dimension.shared.normalHeightButton)
            make.centerY.equalTo(shuffleButton)
        }
    }
    
    private func layoutNextButton() {
        addSubview(nextButton)
        nextButton.snp.makeConstraints { (make) in
            make.right.equalTo(repeatButton.snp.left).offset(-Dimension.shared.largeMargin_45)
            make.height.width.equalTo(Dimension.shared.mediumHeightButton_35)
            make.centerY.equalTo(shuffleButton)
        }
    }
    
    private func layoutBackButton() {
        addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.left.equalTo(shuffleButton.snp.right).offset(Dimension.shared.largeMargin_45)
            make.height.width.equalTo(Dimension.shared.mediumHeightButton_35)
            make.centerY.equalTo(shuffleButton)
        }
    }
    
    private func layoutDeviceButton() {
        addSubview(deviceButton)
        deviceButton.snp.makeConstraints { (make) in
            make.top.equalTo(shuffleButton.snp.bottom).offset(Dimension.shared.largeMargin_45)
            make.height.width.equalTo(shuffleButton)
            make.left.equalTo(collectionViewPlaySong)
        }
    }
    
    private func layoutShareButton() {
        addSubview(shareButton)
        shareButton.snp.makeConstraints { (make) in
            make.top.equalTo(deviceButton)
            make.height.width.equalTo(Dimension.shared.largeMargin_25)
            make.right.equalTo(collectionViewPlaySong)
        }
    }
    
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension DetailViewPlaySong: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DishSongCellCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.delegate = self
        cell.setData()
        self.dishSongCell = cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


//MARK: - DishSongCellDelegate
extension DetailViewPlaySong: DishSongCellDelegate {
    
    func updateCurrentTime() {
        guard let currentTime = MusicPlayer.shared.getCurrentTime() else { return }
        self.currentTimeLabel.getTimeFromCMTime(currentTime)
        
        if !self.isSelctSlider {
            self.timeSlider.value = Float(currentTime.seconds)
        }
    }
}
