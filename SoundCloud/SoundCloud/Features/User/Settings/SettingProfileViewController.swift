//
//  SettingProfileViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/14/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit

class SettingProfileViewController: BaseViewController {

    
    // MARK: - UI Elements
    
    fileprivate lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "1")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 100
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let changeImageButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextManager.setImage.uppercased(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize.h3.rawValue, weight: .semibold)
        button.setTitleColor(UIColor.white, for: .normal)
        button.contentHorizontalAlignment = .center
        button.backgroundColor = .clear
        return button
    }()

    fileprivate lazy var namePlayListTextField: PaddingTextField = {
        let textField = PaddingTextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Đặng Trung Hiếu",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.layer.masksToBounds = true
        textField.textAlignment = .center
        textField.textColor = UIColor.white
        textField.font = UIFont.systemFont(ofSize: FontSize.superHeadline.rawValue, weight: .bold)
        return textField
    }()
    
    fileprivate let descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = TextManager.descriptionProfile
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: FontSize.h1.rawValue)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setRightNavigationBar(ImageManager.close)
        navigationItem.title = "Chỉnh sửa thông tin cá nhân"
        layoutImageView()
        layoutChangeImageButton()
        layoutNamePlayListTextField()
        layoutDescriptionTitleLabel()
    }
    
    override func touchUpInRightBarButtonItem() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func layoutImageView() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide).offset(Dimension.shared.largeMargin)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom).offset(Dimension.shared.largeMargin)
            }
            make.centerX.equalToSuperview()
            make.width.height.equalTo(200)
        }
    }
    
    private func layoutChangeImageButton() {
        view.addSubview(changeImageButton)
        changeImageButton.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom)
            make.centerX.equalTo(imageView)
            make.width.equalTo(300)
        }
    }
    
    private func layoutNamePlayListTextField() {
        view.addSubview(namePlayListTextField)
        namePlayListTextField.snp.makeConstraints { (make) in
            make.height.equalTo(100)
            make.left.equalToSuperview().offset(Dimension.shared.normalMargin)
            make.right.equalToSuperview().offset(-Dimension.shared.normalMargin)
            make.top.equalTo(changeImageButton.snp.bottom).offset(Dimension.shared.largeMargin_25)
        }
    }
    
    private func layoutDescriptionTitleLabel() {
        view.addSubview(descriptionTitleLabel)
        descriptionTitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(Dimension.shared.largeMargin)
            make.right.equalToSuperview().offset(-Dimension.shared.largeMargin)
            make.top.equalTo(namePlayListTextField.snp.bottom).offset(Dimension.shared.smallMargin)
        }
    }
}
