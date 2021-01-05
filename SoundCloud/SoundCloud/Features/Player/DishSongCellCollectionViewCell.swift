//
//  DishSongCellCollectionViewCell.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/1/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit

protocol DishSongCellDelegate: class{
    func updateCurrentTime()
}

class DishSongCellCollectionViewCell: BaseCollectionViewCell, BaseDetailSongMusic {
    
    // MARK: - Variables
    
    private var angleDish: Double = 0
    private var post = Post()
    private var timer: Timer?
    weak var delegate: DishSongCellDelegate?
    
    // MARK: - UI Elements
    
    private var imageSong: UIImageView = {
        let imageConfig = UIImageView()
        imageConfig.contentMode = .scaleAspectFill
        imageConfig.clipsToBounds = true
        imageConfig.image = UIImage(named: "artwork")
        imageConfig.layer.cornerRadius = 300 / 2
        imageConfig.layer.masksToBounds = true
        return imageConfig
    }()
    
    // MARK: - ViewLife Cycles
    
    override func initialize() {
        super.initialize()
    }
    
    
    func setData(data: Any?) {
        if !MusicPlayer.shared.isPlaying {
            self.timer?.invalidate()
            self.timer = nil
            return
        }
        
        guard let postConfig = MusicPlayer.shared.curentSong else { return }
        self.post = postConfig
        
        guard let url = URL(string: self.post.attachments.imageURL) else {
            return
        }
        
        self.startAnimation()
        self.imageSong.sd_setImage(with: url)
        
    }
    
    func setDelegate(delegate: Any?) {
        guard let delegateCofig = delegate as? DishSongCellDelegate else {
            return
        }
        self.delegate = delegateCofig
    }
    
    private func startAnimation() {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { (timer) in
            self.rotateDish()
        })
        
        RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.common)
    }
    
    func stopAnimation() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func rotateDish() {
        self.delegate?.updateCurrentTime()
        
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
    
    //MARK: Layout
    
    private func setupViewImageSong() {
        self.addSubview(self.imageSong)
        self.imageSong.snp.makeConstraints { (make) in
            make.height.equalTo(300)
            make.width.equalTo(self.imageSong.snp.height)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
}
