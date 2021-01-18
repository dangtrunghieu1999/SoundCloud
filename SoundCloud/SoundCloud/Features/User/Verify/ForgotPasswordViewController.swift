//
//  VerifyViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/12/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: BaseViewController {
    
    // MARK: - UI Elements
    
    fileprivate let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = ImageManager.lock
        return imageView
    }()
    
    fileprivate let enterUserNameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = TextManager.weWillSendCodeToEmail
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: FontSize.body.rawValue)
        return label
    }()
    
    fileprivate lazy var userNameTextField: PaddingTextField = {
        let textField = PaddingTextField()
        textField.attributedPlaceholder = NSAttributedString(string:TextManager.emailPlaceHolder,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.layer.cornerRadius = Dimension.shared.largeHeightButton / 2
        textField.backgroundColor = UIColor.spotifyBrown
        textField.layer.masksToBounds = true
        textField.keyboardType = .emailAddress
        textField.font = UIFont.systemFont(ofSize: FontSize.h1.rawValue)
        textField.textColor = UIColor.white
        textField.addTarget(self, action: #selector(textFieldValueChange(_:)), for: .editingChanged)
        return textField
    }()
    
    fileprivate lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextManager.next.uppercased(), for: .normal)
        button.backgroundColor = UIColor.spotifyBrown
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize.h1.rawValue, weight: .medium)
        button.layer.cornerRadius = Dimension.shared.largeHeightButton / 2
        button.layer.masksToBounds = true
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(tapOnNextButton), for: .touchUpInside)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    fileprivate let youDontHaveAccountLabel: UILabel = {
       let label = UILabel()
        label.text = TextManager.youNotHaveAccount
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: FontSize.h3.rawValue)
        return label
    }()
    
    fileprivate lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextManager.signUp, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(tapOnSignUp), for: .touchUpInside)
        return button
    }()
    
    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = TextManager.resetPWTitle.uppercased()
        
        layoutImageView()
        layoutEnterUserNameLabel()
        layoutUserNameTextField()
        layoutNextButton()
        layoutSignUPButton()
        layoutYouDontHaveAccountLabel()
    }
    
    // MARK: - UI Actions
    
    @objc private func textFieldValueChange(_ textField: UITextField) {
        let userName = textField.text ?? ""
        if userName.isUserName {
            nextButton.backgroundColor = UIColor.white
            nextButton.isUserInteractionEnabled = true
        } else {
            nextButton.backgroundColor = UIColor.spotifyBrown
            nextButton.isUserInteractionEnabled = false
        }
    }
    
    @objc private func tapOnSignUp() {
        let viewController = SignUpViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func tapOnNextButton() {
        guard let userName = userNameTextField.text else { return }
        let params = ["email": userName]
        let endPoint = UserEndPoint.forgotPW(bodyParams: params)
        self.showLoading()
        APIService.request(endPoint: endPoint) { (apiResponse) in
            if apiResponse.flag == true {
                self.hideLoading()
                AlertManager.shared.show(message: "Đã reset thành công mật khẩu mới!")
                UIViewController.setRootVCBySinInVC()
            }
        } onFailure: { (serviceError) in
            
        } onRequestFail: {
            
        }

    }
    
    // MARK: - Setup Layouts
    
    private func layoutImageView() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(100 * Dimension.shared.heightScale)
            make.centerX.equalToSuperview()
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40 * Dimension.shared.heightScale)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom).offset(40 * Dimension.shared.heightScale)
            }
        }
    }
    
    private func layoutEnterUserNameLabel() {
        view.addSubview(enterUserNameTitleLabel)
        enterUserNameTitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(Dimension.shared.normalMargin)
            make.left.equalToSuperview().offset(Dimension.shared.largeMargin_30)
            make.right.equalToSuperview().offset(-Dimension.shared.largeMargin_30)
        }
    }
    
    private func layoutUserNameTextField() {
        view.addSubview(userNameTextField)
        userNameTextField.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(Dimension.shared.largeMargin_30)
            make.right.equalTo(view).offset(-Dimension.shared.largeMargin_30)
            make.height.equalTo(Dimension.shared.largeHeightButton)
            make.top.equalTo(enterUserNameTitleLabel.snp.bottom).offset(Dimension.shared.largeMargin)
        }
    }
    
    private func layoutNextButton() {
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { (make) in
            make.width.equalTo(Dimension.shared.largeWidthButton)
            make.height.equalTo(Dimension.shared.largeHeightButton)
            make.top.equalTo(userNameTextField.snp.bottom).offset(Dimension.shared.largeMargin_30)
            make.centerX.equalToSuperview()
        }
    }
    
    private func layoutSignUPButton() {
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { (make) in
            make.width.equalTo(Dimension.shared.mediumWidthButton)
            make.height.equalTo(Dimension.shared.defaultHeightButton)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-Dimension.shared.largeMargin_30)
        }
    }
    
    private func layoutYouDontHaveAccountLabel() {
        view.addSubview(youDontHaveAccountLabel)
        youDontHaveAccountLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(signUpButton.snp.top)
        }
    }
    
    
}
