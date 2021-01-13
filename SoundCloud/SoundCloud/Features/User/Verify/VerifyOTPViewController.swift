//
//  VerifyViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/12/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit

class VerifyOTPViewController: BaseViewController {
    
    
    fileprivate let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = ImageManager.sendMail
        return imageView
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = TextManager.sendCodeRecoverPWInEmail
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: FontSize.body.rawValue)
        return label
    }()
    
    fileprivate lazy var enterCodeTextField: PaddingTextField = {
        let textField = PaddingTextField()
        textField.placeholder = TextManager.yourCode
        textField.layer.borderColor = UIColor.separator.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = Dimension.shared.defaultHeightTextField / 2
        textField.layer.masksToBounds = true
        textField.textColor = UIColor.white
        textField.keyboardType = .numberPad
        textField.addTarget(self, action: #selector(textFieldValueChange(_:)), for: .editingChanged)
        return textField
    }()
    
    fileprivate lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextManager.next, for: .normal)
        button.backgroundColor = UIColor.spotifyBrown
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize.h1.rawValue, weight: .medium)
        button.layer.cornerRadius = Dimension.shared.defaultHeightButton / 2
        button.layer.masksToBounds = true
        button.isUserInteractionEnabled = false
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(tapOnNextButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutImageView()
        layoutMessageLabel()
        layoutEnterCodeTextField()
        layoutNextButton()
    }
    
    @objc func tapOnNextButton() {
        
    }
    
    @objc func textFieldValueChange(_ textField: UITextField) {
        let userName = textField.text ?? ""
        if userName != "" {
            nextButton.backgroundColor = UIColor.white
            nextButton.isUserInteractionEnabled = true
        } else {
            nextButton.backgroundColor = UIColor.spotifyBrown
            nextButton.isUserInteractionEnabled = false
        }
    }
    
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
    
    private func layoutEnterCodeTextField() {
        view.addSubview(enterCodeTextField)
        enterCodeTextField.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(Dimension.shared.largeMargin_30)
            make.right.equalTo(view).offset(-Dimension.shared.largeMargin_30)
            make.height.equalTo(Dimension.shared.defaultHeightTextField)
            make.top.equalTo(titleLabel.snp.bottom).offset(Dimension.shared.largeMargin)
        }
    }
    
    private func layoutNextButton() {
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { (make) in
            make.width.equalTo(Dimension.shared.smallWidthButton)
            make.height.equalTo(Dimension.shared.defaultHeightButton)
            make.centerX.equalToSuperview()
            make.top.equalTo(enterCodeTextField.snp.bottom).offset(Dimension.shared.largeMargin_30)
        }
    }
    
}
