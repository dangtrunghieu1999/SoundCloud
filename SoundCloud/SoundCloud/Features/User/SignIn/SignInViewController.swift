//
//  SignInViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/21/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class SignInViewController: BaseViewController {
    
    // MARK: - UI Elements
    
    fileprivate var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageManager.logoSpotify
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    fileprivate var titleLabel: UILabel = {
        let label = UILabel()
        label.text = TextManager.signInTitle
        label.font = UIFont.systemFont(ofSize: FontSize.headline.rawValue, weight: .bold)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    fileprivate var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextManager.signUnFree, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize.h1.rawValue, weight: .semibold)
        button.setTitleColor(UIColor.white, for: .normal)
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(tapOnSignUp), for: .touchUpInside)
        button.layer.cornerRadius = 25
        button.backgroundColor = UIColor.spotifyGreen
        return button
    }()

    fileprivate var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextManager.signIn, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize.h1.rawValue, weight: .semibold)
        button.setTitleColor(UIColor.white, for: .normal)
        button.contentHorizontalAlignment = .center
        button.addTarget(self,action: #selector(tapOnSignIn), for: .touchUpInside)
        return button
    }()
    
    
    // MARK:- ViewLifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutLogoImagView()
        layoutTitleLabel()
        layoutSignUpButton()
        layoutSignInButton()
    }
    
    // MARK: - UI Action
    
    @objc private func tapOnSignUp() {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    @objc private func tapOnSignIn() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }

    
    // MARK: - Layout
    
    private func layoutLogoImagView() {
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(40)
            make.centerY.equalToSuperview().offset(-Dimension.shared.largeMargin_90)
        }
    }
    
    private func layoutTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom).offset(Dimension.shared.largeMargin)
            make.left.equalToSuperview().offset(Dimension.shared.largeMargin)
            make.right.equalToSuperview().offset(-Dimension.shared.largeMargin)
        }
    }
    
    private func layoutSignUpButton() {
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(Dimension.shared.largeMargin)
            make.left.equalToSuperview().offset(Dimension.shared.largeMargin)
            make.right.equalToSuperview().offset(-Dimension.shared.largeMargin)
            make.height.equalTo(Dimension.shared.largeHeightButton)
        }
    }
    
    private func layoutSignInButton() {
        view.addSubview(signInButton)
        signInButton.snp.makeConstraints { (make) in
            make.top.equalTo(signUpButton.snp.bottom).offset(Dimension.shared.normalMargin)
            make.left.right.equalTo(signUpButton)
            make.height.equalTo(Dimension.shared.largeHeightButton)
        }
    }
    
}
