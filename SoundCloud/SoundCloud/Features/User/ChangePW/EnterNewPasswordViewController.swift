//
//  ChangePasswordViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/18/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit

class EnterNewPasswordViewController: BaseViewController {
    // MARK: - Variables
    
    var code: String = ""
    
    // MARK: - UI Elements
        
    fileprivate let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = ImageManager.unLock
        return imageView
    }()
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.text = TextManager.oneStepToResetPW
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: FontSize.body.rawValue)
        return label
    }()
    
    fileprivate lazy var newPWTextField: PaddingTextField = {
        let textField = PaddingTextField()
        textField.attributedPlaceholder = NSAttributedString(string:TextManager.oldPassword,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.layer.cornerRadius = Dimension.shared.largeHeightButton / 2
        textField.layer.masksToBounds = true
        textField.isSecureTextEntry = true
        textField.textColor = UIColor.white
        textField.font = UIFont.systemFont(ofSize: FontSize.h1.rawValue)
        textField.backgroundColor = UIColor.spotifyBrown
        textField.addTarget(self, action: #selector(textFieldValueChange(_:)), for: .editingChanged)
        return textField
    }()
    
    fileprivate lazy var confimNewPWTextField: PaddingTextField = {
        let textField = PaddingTextField()
        textField.attributedPlaceholder = NSAttributedString(string:TextManager.newPassword,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.layer.cornerRadius = Dimension.shared.largeHeightButton / 2
        textField.layer.masksToBounds = true
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor.spotifyBrown
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
    
    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = TextManager.changePassword
        
        layoutImageView()
        layoutMessageLabel()
        layoutNewPWTextField()
        layoutConfimNewPWTextField()
        layoutNextButton()
    }
    
    // MARK: - UI Actions
    
    @objc private func textFieldValueChange(_ textField: UITextField) {
        let passWord = newPWTextField.text ?? ""
        let confirmPassWord = confimNewPWTextField.text ?? ""
        if passWord != "" && confirmPassWord != "" {
            nextButton.backgroundColor = UIColor.white
            nextButton.isUserInteractionEnabled = true
        } else {
            nextButton.backgroundColor = UIColor.spotifyBrown
            nextButton.isUserInteractionEnabled = false
        }
    }
    
    @objc private func tapOnNextButton() {
        guard let odlPW = newPWTextField.text else { return }
        guard let newPW = confimNewPWTextField.text else { return }
        let params = ["oldPass": odlPW, "newPass": newPW]
        let endPoint = UserEndPoint.createNewPW(bodyParams: params)
        self.showLoading()
        APIService.request(endPoint: endPoint) { (apiResponse) in
            if apiResponse.flag == true {
                self.hideLoading()
                AlertManager.shared.show(message: "Đã thay đổi mật khẩu thành công")
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
    
    private func layoutMessageLabel() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(Dimension.shared.normalMargin)
            make.left.equalToSuperview().offset(Dimension.shared.largeMargin_30)
            make.right.equalToSuperview().offset(-Dimension.shared.largeMargin_30)
        }
    }
    
    private func layoutNewPWTextField() {
        view.addSubview(newPWTextField)
        newPWTextField.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(Dimension.shared.largeMargin_30)
            make.right.equalTo(view).offset(-Dimension.shared.largeMargin_30)
            make.height.equalTo(Dimension.shared.largeHeightButton)
            make.top.equalTo(titleLabel.snp.bottom).offset(Dimension.shared.largeMargin)
        }
    }
    
    private func layoutConfimNewPWTextField() {
        view.addSubview(confimNewPWTextField)
        confimNewPWTextField.snp.makeConstraints { (make) in
            make.width.height.centerX.equalTo(newPWTextField)
            make.top.equalTo(newPWTextField.snp.bottom).offset(Dimension.shared.normalMargin)
        }
    }
    
    private func layoutNextButton() {
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { (make) in
            make.width.equalTo(Dimension.shared.largeWidthButton)
            make.height.equalTo(Dimension.shared.largeHeightButton)
            make.centerX.equalToSuperview()
            make.top.equalTo(confimNewPWTextField.snp.bottom).offset(Dimension.shared.largeMargin_30)
        }
    }

}
