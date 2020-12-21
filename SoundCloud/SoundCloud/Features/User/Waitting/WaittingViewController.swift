//
//  WaittingViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/21/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class WaittingViewController: BaseViewController, BaseAlertViewController {
    
    //MARK: UIControl
    private let darkView: UIView = {
        let viewConfig = UIView()
        viewConfig.alpha = 0
        viewConfig.backgroundColor = UIColor.background
        return viewConfig
    }()
    
    private var indicatorView = NVActivityIndicatorView(frame: .zero)
    //MARK: Feature function
    
    func show() {
        guard let window = UIApplication.shared.keyWindow else { return }
        
        self.setupViewDarkView(window: window)
        self.setupViewIndicatorView(window: window)
    
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .curveLinear, animations: {
            self.darkView.alpha = 1
            self.indicatorView.alpha = 1
        }) { (finish) in
            self.indicatorView.startAnimating()
        }
    }
    
    
    func hide() {
        self.indicatorView.alpha = 0
        self.indicatorView.stopAnimating()
        
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .curveLinear, animations: {
            self.darkView.alpha = 0
        }) { (finish) in
            //
        }
    }
    
    //MARK: SetupView function
    private func setupViewDarkView(window: UIWindow) {
        self.darkView.alpha = 0
        window.addSubview(self.darkView)
        
        self.darkView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupViewIndicatorView(window: UIWindow) {
        self.indicatorView.alpha = 0
        let type = NVActivityIndicatorType.ballPulseSync
        let color = UIColor.white
        self.indicatorView = NVActivityIndicatorView(frame: .zero, type: type, color: color, padding: 1)
        
        window.addSubview(self.indicatorView)
        self.indicatorView.snp.makeConstraints { (make) in
            make.width.equalTo(80 * Dimension.shared.widthScale)
            make.height.equalTo(36 * Dimension.shared.widthScale)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
