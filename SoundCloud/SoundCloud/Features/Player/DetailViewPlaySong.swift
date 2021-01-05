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
    
    fileprivate var currentPost: Post?
    fileprivate var isSelctSlider: Bool = false
    
    private let backGroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "ChiPu")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.makeVisualEffect()
        return imageView
    }()
    
    fileprivate lazy var viewPlaySongCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear
        //        collectionView.delegate = self
        //        collectionView.dataSource = self
        collectionView.registerReusableCell(DishSongCellCollectionViewCell.self)
        collectionView.registerReusableCell(ListPlaySongCell.self)
        return collectionView
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
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
        slider.setThumbImage(IConPlaySongVC.thumbImage.image, for: .normal)
        return slider
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setImage(IConPlaySongVC.playIcon.image, for: .normal)
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
    
    //MARK: Action UIControl
    @objc func playButtonPressed() {
        MusicPlayer.shared.pause()
    }
    
    @objc func nextButtonPressed() {
        MusicPlayer.shared.nextPlay()
    }
    
    @objc func backButtonPressed() {
        MusicPlayer.shared.backPlay()
    }
    
    @objc func fakePanGesture() {
        
    }
    
    @objc func seekSlider(_ sender: UISlider) {
        self.isSelctSlider = false
        MusicPlayer.shared.seekToTime(sender.value)
    }
    
    @objc func didBeginSelectSlider() {
        self.isSelctSlider = true
    }
    
    @objc func reloadPlayList() {
        self.viewPlaySongCollection.reloadData()
    }
    
    @objc func pausePlaySong() {
        self.checkShowImagePlayIcon()
        self.viewPlaySongCollection.reloadData()
    }
    
    @objc func continuePlaySong() {
        self.checkShowImagePlayIcon()
        self.viewPlaySongCollection.reloadData()
    }
    
    
    //MARK: Suport Function
    @objc func startPlaySong() {
        self.viewPlaySongCollection.reloadData()
        self.currentPost = MusicPlayer.shared.curentSong
        
        //Set backgroundImage
        if let post = self.currentPost {
            guard let url = URL(string: post.attachments.imageURL) else {
                return
            }
            
            self.backGroundImage.sd_setImage(with: url)
        }
        
        self.setViewWhenPlaySong()
    }
    
    @objc func stopPlaySong() {
        self.checkShowImagePlayIcon()
        self.viewPlaySongCollection.reloadData()
    }
    
    private func setViewWhenPlaySong() {
        self.checkShowImagePlayIcon()
        
        MusicPlayer.shared.getDuration { (cmTime) in
            guard let duration = cmTime else { return }
            
            self.timeIntervalLabel.getTimeFromCMTime(duration)
            self.timeSlider.maximumValue = Float(CMTimeGetSeconds(duration))
        }
        
    }
    
    fileprivate func checkShowImagePlayIcon() {
        if MusicPlayer.shared.isPlaying {
            self.playButton.setImage(IConPlaySongVC.playIcon.image, for: .normal)
        } else {
            self.playButton.setImage(IConPlaySongVC.pauseIcon.image, for: .normal)
        }
    }
    
    //MARK: SetupView function
    private func setViewBackgroundImage() {
        self.addSubview(self.backGroundImage)
        
        self.backGroundImage.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupViewCollectionViewSong() {
        self.addSubview(self.viewPlaySongCollection)
        
        self.viewPlaySongCollection.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(4 * Dimension.shared.normalMargin)
        }
    }
    
    private func setupViewBackgroundView() {
        self.addSubview(self.backgroundView)
        
        self.backgroundView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.equalTo(self.viewPlaySongCollection.snp.bottom).offset(Dimension.shared.normalMargin)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        let pangesture = UIPanGestureRecognizer(target: self, action: #selector(DetailViewPlaySong.fakePanGesture))
        self.backgroundView.addGestureRecognizer(pangesture)
    }
    
    private func setupViewTimeSlider() {
        addSubview(timeSlider)
        timeSlider.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.7)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.viewPlaySongCollection.snp.bottom).offset(2 * Dimension.shared.normalMargin)
        }
        timeSlider.addTarget(self, action: #selector(seekSlider(_:)), for: .touchUpInside)
        timeSlider.addTarget(self, action: #selector(didBeginSelectSlider), for: .valueChanged)
    }
    
    private func setupViewCurrentTimeLabel() {
        addSubview(self.currentTimeLabel)
        currentTimeLabel.snp.makeConstraints { (make) in
            make.width.equalTo(40 * Dimension.shared.widthScale)
            make.left.equalToSuperview().offset(Dimension.shared.normalMargin / 2)
            make.centerY.equalTo(timeSlider)
        }
    }
    
    private func setupViewTimeIntervalLabel() {
        addSubview(timeIntervalLabel)
        timeIntervalLabel.snp.makeConstraints { (make) in
            make.width.equalTo(currentTimeLabel)
            make.right.equalToSuperview().offset(-Dimension.shared.normalMargin / 2)
            make.centerY.equalTo(self.timeSlider)
        }
    }
    
    private func  setupViewPlayButton() {
        addSubview(self.playButton)
        playButton.snp.makeConstraints { (make) in
            make.height.equalTo(35)
            make.width.equalTo(self.playButton.snp.height)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.timeSlider.snp.bottom).offset(2 * Dimension.shared.normalMargin)
        }
        
        self.playButton.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
    }
    
    private func  setupViewNextButton() {
        addSubview(nextButton)
        nextButton.snp.makeConstraints { (make) in
            make.height.equalTo(35 * 0.65)
            make.width.equalTo(nextButton.snp.height)
            make.left.equalTo(playButton.snp.right).offset(2.5 * Dimension.shared.normalMargin)
            make.centerY.equalTo(playButton)
        }
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
    }
    
    private func  setupViewBackButton() {
        addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.height.equalTo(self.nextButton)
            make.width.equalTo(self.nextButton.snp.height)
            make.right.equalTo(self.playButton.snp.left).offset(-2.5 * Dimension.shared.normalMargin)
            make.centerY.equalTo(self.playButton)
        }
        
        self.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension DetailViewPlaySong: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell: DishSongCellCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setData(data: nil)
            cell.setDelegate(delegate: self)
            return cell
        } else {
            let cell: ListPlaySongCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setData(data: nil)
            cell.setDelegate(delegate: self)
            return cell
        }
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

