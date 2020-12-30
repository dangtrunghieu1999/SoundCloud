//
//  StationTableViewCell.swift
//  Swift Radio
//
//  Created by Matthew Fecher on 4/4/15.
//  Copyright (c) 2015 MatthewFecher.com. All rights reserved.
//

import UIKit

class StationTableViewCell: BaseTableViewCell {
    
    
    fileprivate lazy var stationNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: FontSize.h1.rawValue, weight: .semibold)
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate lazy var stationDescLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: FontSize.h2.rawValue, weight: .medium)
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate lazy var stationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "stationImage")
        return imageView
    }()
    
    fileprivate var downloadTask: URLSessionDownloadTask?
    
    override func initialize() {
        super.initialize()
        stationImageView.applyShadow()
        let selectedView = UIView(frame: CGRect.zero)
        selectedView.backgroundColor = UIColor(red: 78/255, green: 82/255, blue: 93/255, alpha: 0.6)
        selectedBackgroundView  = selectedView
        layoutStationImageView()
        layoutStationNameLabel()
        layoutStationDescLabel()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        downloadTask?.cancel()
        downloadTask = nil
        stationNameLabel.text  = nil
        stationDescLabel.text  = nil
        stationImageView.image = nil
    }
    
    func configureStationCell(station: RadioStation) {
        
        // Configure the cell...
        stationNameLabel.text = station.name
        stationDescLabel.text = station.desc
        
        let imageURL = station.imageURL as NSString
        if imageURL.contains("http"), let url = URL(string: station.imageURL) {
            stationImageView.loadImageWithURL(url: url) { (image) in
                // station image loaded
            }
        } else if imageURL != "" {
            stationImageView.image = UIImage(named: imageURL as String)
        } else {
            stationImageView.image = UIImage(named: "stationImage")
        }
    }
    
    // MARK: - Layout
    
    private func layoutStationImageView(){
        addSubview(stationImageView)
        stationImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(Dimension.shared.mediumMargin)
            make.width.equalTo(120)
            make.height.equalTo(75)
            make.centerY.equalToSuperview()
        }
    }
    
    private func layoutStationNameLabel(){
        addSubview(stationNameLabel)
        stationNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(stationImageView.snp.right).offset(Dimension.shared.mediumMargin)
            make.top.equalToSuperview().offset(Dimension.shared.normalMargin)
            make.right.equalToSuperview().offset(-Dimension.shared.mediumMargin)
        }
    }
    
    private func layoutStationDescLabel(){
        addSubview(stationDescLabel)
        stationDescLabel.snp.makeConstraints { (make) in
            make.left.equalTo(stationImageView.snp.right).offset(Dimension.shared.mediumMargin)
            make.bottom.equalToSuperview().offset(Dimension.shared.normalMargin)
            make.right.equalToSuperview().offset(-Dimension.shared.mediumMargin)
        }
    }
    

}
