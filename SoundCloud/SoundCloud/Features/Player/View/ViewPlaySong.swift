//
//  ViewPlaySong.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/29/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class ViewPlaySong: BaseView {
    
    //MARK: Variable
    private var angleDish: Double = 0
    private var song = Song()
    private var timer: Timer?
    
    //MARK: UIControl
    private var imageSong: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Dimension.shared.imageViewPlayMusic / 2
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        let labelConfig = UILabel()
        labelConfig.textColor = UIColor.white
        labelConfig.textAlignment = .left
        labelConfig.font = UIFont.systemFont(ofSize: FontSize.h1.rawValue, weight: .bold)
        return labelConfig
    }()
    
    private var disPlayNameLabel: UILabel = {
        let labelConfig = UILabel()
        labelConfig.textColor = UIColor.white
        labelConfig.textAlignment = .left
        labelConfig.font = UIFont.systemFont(ofSize: FontSize.h2.rawValue)
        return labelConfig
    }()
    
    //MARK: Initialize function
    override func initialize() {
        super.initialize()
        self.backgroundColor = UIColor.mainBackground
        self.layoutViewImageSong()
        self.layoutNameLabel()
        self.layoutDisplayNameLabel()
    }

    //MARK: Support function
    
    func setData(song: Song) {
        self.song = song
        self.nameLabel.text = self.song.title.capitalizingFirstLetter()
        let artist = CommonMethod.convertArrayToStringText(data: song.listArtists)
        self.disPlayNameLabel.text = artist
        guard let url = URL(string: self.song.image) else {
            return
        }

        self.imageSong.sd_setImage(with: url)
        self.startAnimation()
    }
        
    func startAnimation() {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer) in
            self.rotateDish()
        })
        
        RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.common)
    }
    
    func stopAnimation() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func rotateDish() {
        self.angleDish += 1
        if self.angleDish == 360 {
            self.angleDish = 0
        }
        
        let MPI_Angle = CGFloat(self.angleDish / 180 * .pi)
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear, animations: {
            self.imageSong.layer.transform = CATransform3DMakeRotation(MPI_Angle, 0, 0, 1)
        }) { (finish) in
            
        }
    }
    
    
    //MARK: SetupView function
    private func layoutViewImageSong() {
        addSubview(imageSong)
        imageSong.snp.makeConstraints { (make) in
            make.height.width.equalTo(Dimension.shared.imageViewPlayMusic)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(Dimension.shared.normalMargin)
        }
    }
    
    private func layoutNameLabel() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(Dimension.shared.multipliedByDefault)
            make.top.equalTo(imageSong).offset(Dimension.shared.normalMargin / 2)
            make.left.equalTo(imageSong.snp.right).offset(Dimension.shared.normalMargin)
        }
    }
    
    private func layoutDisplayNameLabel() {
        addSubview(disPlayNameLabel)
        disPlayNameLabel.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(Dimension.shared.multipliedByDefault)
            make.top.equalTo(nameLabel.snp.bottom)
            make.left.equalTo(nameLabel)
        }
    }
    
}

//MARK: - Extension
extension ViewPlaySong {
    func makeShadow(color: UIColor, size: CGSize, opacity: Float, radius: CGFloat) {
        //self.layer.masksToBounds = false
        func dropShadow(scale: Bool = true) {
            self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 1
            self.layer.shadowOffset = CGSize(width: 0, height: -10)
            self.layer.shadowRadius = 1
            
            self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        }
    }
}







