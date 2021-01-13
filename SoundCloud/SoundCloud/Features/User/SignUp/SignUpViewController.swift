//
//  SignUpViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/29/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class SignUpViewController: BaseViewController {
    
    private var selectedDate = AppConfig.defaultDate
    
    fileprivate lazy var viewModel: SignUpViewModel = {
        let viewModel = SignUpViewModel()
        return viewModel
    }()
    
    // MARK: - UI Elements
    
    fileprivate lazy var emailTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Email của bạn là gì?"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: FontSize.headline.rawValue, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    fileprivate lazy var emailTextField: PaddingTextField = {
        let textField = PaddingTextField()
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.backgroundColor = UIColor.spotifyBrown
        textField.layer.masksToBounds = true
        textField.textColor = UIColor.white
        textField.addTarget(self, action: #selector(textFieldValueChange(_:)), for: .editingChanged)
        return textField
    }()
    
    fileprivate lazy var passwordTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tạo mật khẩu"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: FontSize.headline.rawValue, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    fileprivate lazy var passwordTextField: PaddingTextField = {
        let textField = PaddingTextField()
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.backgroundColor = UIColor.spotifyBrown
        textField.layer.masksToBounds = true
        textField.isSecureTextEntry = true
        textField.textColor = UIColor.white
        textField.addTarget(self, action: #selector(textFieldValueChange(_:)), for: .editingChanged)
        return textField
    }()
    
    fileprivate lazy var usernameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tên của bạn là gì?"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: FontSize.headline.rawValue, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    fileprivate lazy var usernameTextField: PaddingTextField = {
        let textField = PaddingTextField()
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.backgroundColor = UIColor.spotifyBrown
        textField.layer.masksToBounds = true
        textField.textColor = UIColor.white
        textField.addTarget(self, action: #selector(textFieldValueChange(_:)), for: .editingChanged)
        return textField
    }()
    
    fileprivate let DOBTitleLabel: UILabel = {
        let label = UILabel()
        label.text = TextManager.dateOfBirth
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: FontSize.headline.rawValue, weight: .bold)
        return label
    }()
    
    fileprivate lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.locale = Locale(identifier: "Vi")
        datePicker.datePickerMode = .date
        datePicker.minimumDate = AppConfig.minDate
        datePicker.maximumDate = Date()
        datePicker.date = selectedDate
        datePicker.addTarget(self, action: #selector(datePickerChange(_:)), for: .valueChanged)
        return datePicker
    }()
    
    fileprivate lazy var DOBTextField: PaddingTextField = {
        let textField = PaddingTextField()
        textField.placeholder = TextManager.dateOfBirth
        textField.layer.masksToBounds = true
        textField.inputView = datePicker
        textField.backgroundColor = UIColor.spotifyBrown
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.textColor = UIColor.white
        textField.text = selectedDate.desciption(by: DateFormat.shortDateUserFormat)
        return textField
    }()
    
    fileprivate var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextManager.signUp, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize.h1.rawValue, weight: .semibold)
        button.setTitleColor(UIColor.black, for: .normal)
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(tapOnSignUp), for: .touchUpInside)
        button.layer.cornerRadius = 25
        button.isUserInteractionEnabled = false
        button.backgroundColor = UIColor.spotifyBrown
        return button
    }()
    
    
    // MARK: - View LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = TextManager.signUp
        layoutEmailTitleLabel()
        layoutEmailTextField()
        layoutPasswordTitleLabel()
        layoutPasswordTextField()
        layoutUserNameTitleLabel()
        layoutUserNameTextField()
        layoutDOBTitleLabel()
        layoutDOBTextField()
        layoutSignUpButton()
    }
    
    @objc private func tapOnSignUp() {
        //        guard let email = emailTextField.text,
        //              let userName = usernameTextField.text,
        //              let password = passwordTextField.text
        //        else {
        //            return
        //        }
        
//        showLoading()
        let vc = VerifyOTPViewController()
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    @objc private func datePickerChange(_ picker: UIDatePicker) {
        selectedDate = picker.date
        DOBTextField.text = selectedDate.desciption(by: DateFormat.shortDateUserFormat)
        textFieldValueChange(DOBTextField)
    }
    
    @objc private func textFieldValueChange(_ textField: UITextField) {
        guard let email = emailTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
//        if email != "" && username != "" && password != "" && selectedDate != nil {
//            signUpButton.isUserInteractionEnabled = true
//            signUpButton.backgroundColor = UIColor.white
//        } else {
//            signUpButton.isUserInteractionEnabled = false
//            signUpButton.backgroundColor = UIColor.spotifyBrown
//        }
        
        if viewModel.canSignUp(email: email, password: password, userName: username, dob: selectedDate) {
            signUpButton.isUserInteractionEnabled = true
            signUpButton.backgroundColor = UIColor.white
        } else {
            signUpButton.isUserInteractionEnabled = false
            signUpButton.backgroundColor = UIColor.spotifyBrown
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
            make.height.equalTo(50)
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
            make.height.equalTo(50)
        }
    }
    
    private func layoutUserNameTitleLabel() {
        view.addSubview(usernameTitleLabel)
        usernameTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(Dimension.shared.normalMargin)
            make.left.equalTo(emailTitleLabel)
        }
    }
    
    private func layoutUserNameTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(usernameTitleLabel.snp.bottom).offset(Dimension.shared.smallMargin)
            make.left.right.equalTo(emailTextField)
            make.height.equalTo(50)
        }
    }
    
    private func layoutDOBTitleLabel() {
        view.addSubview(DOBTitleLabel)
        DOBTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(emailTitleLabel)
            make.top.equalTo(usernameTextField.snp.bottom).offset(Dimension.shared.normalMargin)
        }
    }
    
    private func layoutDOBTextField() {
        view.addSubview(DOBTextField)
        DOBTextField.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.left.right.equalTo(emailTextField)
            make.top.equalTo(DOBTitleLabel.snp.bottom).offset(Dimension.shared.smallMargin)
        }
    }
    
    private func layoutSignUpButton() {
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(DOBTextField.snp.bottom).offset(Dimension.shared.largeMargin)
        }
    }
}
