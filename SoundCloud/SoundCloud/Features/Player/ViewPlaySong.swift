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
    private var post = Post()
    private var timer: Timer?
    
    //MARK: UIControl
    private var imageSong: UIImageView = {
        let imageConfig = UIImageView()
        imageConfig.contentMode = .scaleAspectFill
        imageConfig.clipsToBounds = true
        imageConfig.image = UIImage(named: "2020")
        return imageConfig
    }()
    
    private var nameLabel: UILabel = {
        let labelConfig = UILabel()
        labelConfig.textColor = UIColor.white
        labelConfig.textAlignment = .left
        labelConfig.font = UIFont.systemFont(ofSize: FontSize.h1.rawValue, weight: .bold)
        labelConfig.text = "Hãy trao cho anh"
        return labelConfig
    }()
    
    private var disPlayNameLabel: UILabel = {
        let labelConfig = UILabel()
        labelConfig.textColor = UIColor.white
        labelConfig.textAlignment = .left
        labelConfig.font = UIFont.systemFont(ofSize: FontSize.h2.rawValue)
        labelConfig.text = "Sơn Tùng MTP"
        return labelConfig
    }()
    
    //MARK: Initialize function
    override func initialize() {
        super.initialize()
        
        self.backgroundColor = UIColor.mainBackground
        self.setupViewImageSong()
        self.setupviewNameLabel()
        self.setupviewDisplayNameLabel()
    }
    
    //MARK: Public fucntion
    @objc func startPlaySong() {
        guard let post = MusicPlayer.shared.curentSong else { return }
        self.post = post
        
        self.setData()
        self.startAnimation()
    }
    
    //MARK: Support function
    private func setData() {
//        self.nameLabel.text = self.post.title
//        self.disPlayNameLabel.text = self.post.user?.displayName
//        guard let url = URL(string: self.post.attachments.imageURL) else {
//            return
//        }
//
//        self.imageSong.sd_setImage(with: url)
    }
    
    private func startAnimation() {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer) in
            self.rotateDish()
        })
        
        RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.common)
    }
    
    @objc func stopAnimation() {
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
            //
        }
    }
    
    @objc func pausePlaySong() {
        self.stopAnimation()
    }
    
    @objc func continuePlaySong() {
        self.startAnimation()
    }
    
    //MARK: SetupView function
    private func setupViewImageSong() {
        self.addSubview(self.imageSong)
        
        self.imageSong.snp.makeConstraints { (make) in
            make.height.equalTo(54)
            make.width.equalTo(self.imageSong.snp.height)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(Dimension.shared.normalMargin)
        }
        
        self.imageSong.layer.cornerRadius = 54 / 2
        self.imageSong.layer.masksToBounds = true
    }
    
    private func setupviewNameLabel() {
        self.addSubview(self.nameLabel)
        
        self.nameLabel.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.7)
            make.top.equalTo(self.imageSong).offset(Dimension.shared.normalMargin / 2)
            make.left.equalTo(self.imageSong.snp.right).offset(Dimension.shared.normalMargin)
        }
    }
    
    private func setupviewDisplayNameLabel() {
        self.addSubview(self.disPlayNameLabel)
        
        self.disPlayNameLabel.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.7)
            make.top.equalTo(self.nameLabel.snp.bottom)
            make.left.equalTo(self.nameLabel)
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







