//
//  SignUpViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/29/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class SignUpViewController: BaseViewController {
    
    var selectedGender = true
    
    var gender: [String] = ["Nam","Nữ"]
    
    fileprivate lazy var viewModel: SignUpViewModel = {
        let viewModel = SignUpViewModel()
        return viewModel
    }()
    
    // MARK: - UI Elements
    
    fileprivate lazy var emailTitleLabel: UILabel = {
        let label = UILabel()
        label.text = TextManager.emailPlaceHolder
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
        textField.keyboardType = .emailAddress
        textField.addTarget(self, action: #selector(textFieldValueChange(_:)), for: .editingChanged)
        return textField
    }()
    
    fileprivate lazy var passwordTitleLabel: UILabel = {
        let label = UILabel()
        label.text = TextManager.passwordPlaceHolder
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
    
    fileprivate lazy var usernameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = TextManager.namePlaceHolder
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: FontSize.headline.rawValue, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    fileprivate lazy var usernameTextField: PaddingTextField = {
        let textField = PaddingTextField()
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = Dimension.shared.largeHeightButton / 2
        textField.backgroundColor = UIColor.spotifyBrown
        textField.layer.masksToBounds = true
        textField.textColor = UIColor.white
        textField.addTarget(self, action: #selector(textFieldValueChange(_:)), for: .editingChanged)
        return textField
    }()
    
    fileprivate lazy var genderTitleLabel: UILabel = {
        let label = UILabel()
        label.text = TextManager.gender
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: FontSize.headline.rawValue, weight: .bold)
        return label
    }()
    
    fileprivate lazy var genderPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    fileprivate lazy var genderTextField: PaddingTextField = {
        let textField = PaddingTextField()
        textField.layer.borderWidth = 1
        textField.attributedPlaceholder = NSAttributedString(string:TextManager.male,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.layer.cornerRadius = Dimension.shared.largeHeightButton / 2
        textField.backgroundColor = UIColor.spotifyBrown
        textField.layer.masksToBounds = true
        textField.textColor = UIColor.white
        textField.inputView = genderPickerView
        textField.font = UIFont.systemFont(ofSize: FontSize.h1.rawValue, weight: .bold)
        textField.rightImage = ImageManager.dropDown
        textField.addTarget(self, action: #selector(textFieldBeginEditing), for: .touchUpInside)
        textField.addTarget(self, action: #selector(textFieldValueChange(_:)), for: .editingChanged)
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
        layoutGenderTitleLabel()
        layoutGenderTextField()
        layoutSignUpButton()
    }
    
    @objc private func tapOnSignUp() {
                guard let email = emailTextField.text,
                      let userName = usernameTextField.text,
                      let password = passwordTextField.text
                else {
                    return
                }

        guard password.count >= AppConfig.minPasswordLenght else {
                AlertManager.shared.show(message: TextManager.pwNotEnoughLength)
                return
        }

        showLoading()
        
        if viewModel.canSignUp(email: email, password: password, userName: userName, gender: selectedGender) {
            viewModel.requestSignUp(email: email, userName: userName, password: password, gender: selectedGender) {
                self.hideLoading()
                guard let window = UIApplication.shared.keyWindow else { return }
                window.rootViewController = ZTabBarViewController()
            } onError: { (message) in
                self.hideLoading()
                AlertManager.shared.show(TextManager.alertTitle, message: message)
            }
        }
    }
    
    
    @objc private func textFieldBeginEditing() {
        guard let textGender = genderTextField.text else {
            return
        }
        if textGender == "Nam" {
            selectedGender = true
        } else {
            selectedGender = false
        }
    }
    
    @objc private func textFieldValueChange(_ textField: UITextField) {
        guard let email = emailTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        if viewModel.canSignUp(email: email, password: password, userName: username,gender: selectedGender ) {
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
            make.height.equalTo(Dimension.shared.largeHeightButton)
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
            make.height.equalTo(Dimension.shared.largeHeightButton)
        }
    }
    
    private func layoutGenderTitleLabel() {
        view.addSubview(genderTitleLabel)
        genderTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(usernameTitleLabel)
            make.top.equalTo(usernameTextField.snp.bottom).offset(Dimension.shared.normalMargin)
        }
    }
    
    private func layoutGenderTextField() {
        view.addSubview(genderTextField)
        genderTextField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(Dimension.shared.normalMargin)
            make.height.equalTo(Dimension.shared.largeHeightButton)
            make.top.equalTo(genderTitleLabel.snp.bottom).offset(Dimension.shared.smallMargin)
            make.right.equalToSuperview().offset(-Dimension.shared.normalMargin)
        }
    }
    
    private func layoutSignUpButton() {
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(Dimension.shared.largeHeightButton)
            make.centerX.equalToSuperview()
            make.top.equalTo(genderTextField.snp.bottom).offset(Dimension.shared.largeMargin)
        }
    }
}

extension SignUpViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == genderPickerView {
            return gender[row]
        } else {
            return gender[row]
        }
    }
}

extension SignUpViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,
                    inComponent component: Int) {
        genderTextField.text = gender[row]
    }
}
