//
//  LoginViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/28/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    fileprivate lazy var viewModel: SignInViewModel = {
        let viewModel = SignInViewModel()
        return viewModel
    }()

    // MARK: - UI Elements
    
    fileprivate lazy var emailTitleLabel: UILabel = {
        let label = UILabel()
        label.text = TextManager.email
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: FontSize.headline.rawValue, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    fileprivate lazy var emailTextField: PaddingTextField = {
        let textField = PaddingTextField()
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = Dimension.shared.largeHeightButton / 2
        textField.backgroundColor = UIColor.spotifyBrown
        textField.layer.masksToBounds = true
        textField.textColor = UIColor.white
        textField.addTarget(self, action: #selector(textFieldValueChange(_:)), for: .editingChanged)
        return textField
    }()
    
    fileprivate lazy var passwordTitleLabel: UILabel = {
        let label = UILabel()
        label.text = TextManager.password
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: FontSize.headline.rawValue, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    fileprivate lazy var passwordTextField: PaddingTextField = {
        let textField = PaddingTextField()
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = Dimension.shared.largeHeightButton / 2
        textField.backgroundColor = UIColor.spotifyBrown
        textField.layer.masksToBounds = true
        textField.isSecureTextEntry = true
        textField.textColor = UIColor.white
        textField.addTarget(self, action: #selector(textFieldValueChange(_:)), for: .editingChanged)
        return textField
    }()

    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextManager.signIn, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize.h1.rawValue, weight: .semibold)
        button.setTitleColor(UIColor.black, for: .normal)
        button.contentHorizontalAlignment = .center
        button.layer.cornerRadius = 25
        button.backgroundColor = UIColor.spotifyBrown
        button.isUserInteractionEnabled = false
        button.addTarget(self,action: #selector(tapOnSignIn), for: .touchUpInside)
        return button
    }()
    
    private let fortgotPassword: UIButton = {
        let button = UIButton()
        button.setTitle(TextManager.forgot, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize.h3.rawValue, weight: .semibold)
        button.setTitleColor(UIColor.white, for: .normal)
        button.contentHorizontalAlignment = .center
        button.layer.cornerRadius = Dimension.shared.mediumHeightButton / 2
        button.addTarget(self,action: #selector(tapOnForgotPassword), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = TextManager.signIn
        layoutEmailTitleLabel()
        layoutEmailTextField()
        layoutPasswordTitleLabel()
        layoutPasswordTextField()
        layoutSignInButton()
        layoutForgotPasswordButton()
    }
    
    // MARK: - UI Action
    
    @objc private func textFieldValueChange(_ textField: UITextField) {
        guard let email    = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        if (email != "" && password != "") {
            signInButton.isUserInteractionEnabled = true
            signInButton.backgroundColor = UIColor.white
        } else {
            signInButton.isUserInteractionEnabled = false
            signInButton.backgroundColor = UIColor.spotifyBrown
        }
    }
    
    @objc private func tapOnForgotPassword() {
        let vc = ForgotPasswordViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func tapOnSignIn() {
        
        guard let userName = emailTextField.text, let passWord = passwordTextField.text else {
            return
        }
        showLoading()
        viewModel.requestSignIn(userName: userName, passWord: passWord, onSuccess: {
            self.hideLoading()
            guard let window = UIApplication.shared.keyWindow else { return }
            window.rootViewController = ZTabBarViewController()
        }) { (message) in
            self.hideLoading()
            AlertManager.shared.show(TextManager.alertTitle, message: message)
        }
    }
    
    private func layoutEmailTitleLabel() {
        view.addSubview(emailTitleLabel)
        emailTitleLabel.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide).offset(Dimension.shared.mediumMargin)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom).offset(Dimension.shared.mediumMargin)
            }
            make.left.equalToSuperview().offset(Dimension.shared.largeMargin)
        }
    }
    
    private func layoutEmailTextField() {
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTitleLabel.snp.bottom).offset(Dimension.shared.smallMargin)
            make.left.equalToSuperview().offset(Dimension.shared.normalMargin)
            make.right.equalToSuperview().offset(-Dimension.shared.normalMargin)
            make.height.equalTo(Dimension.shared.largeHeightButton)
        }
    }
    
    private func layoutPasswordTitleLabel() {
        view.addSubview(passwordTitleLabel)
        passwordTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(Dimension.shared.normalMargin)
            make.left.equalTo(emailTitleLabel)
        }
    }
    
    private func layoutPasswordTextField() {
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTitleLabel.snp.bottom).offset(Dimension.shared.smallMargin)
            make.left.right.equalTo(emailTextField)
            make.height.equalTo(Dimension.shared.largeHeightButton)
        }
    }
    
    private func layoutSignInButton() {
        view.addSubview(signInButton)
        signInButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(Dimension.shared.largeMargin_50)
            make.width.equalTo(Dimension.shared.largeWidthButton)
            make.height.equalTo(Dimension.shared.largeHeightButton)
            make.centerX.equalToSuperview()
        }
    }
    
    private func layoutForgotPasswordButton() {
        view.addSubview(fortgotPassword)
        fortgotPassword.snp.makeConstraints { (make) in
            make.top.equalTo(signInButton.snp.bottom).offset(Dimension.shared.normalMargin)
            make.width.equalTo(Dimension.shared.mediumWidthButton)
            make.centerX.equalToSuperview()
            make.height.equalTo(Dimension.shared.mediumHeightButton)
        }
    }

}
