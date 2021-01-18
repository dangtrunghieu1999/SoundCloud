//
//  YourPlayListViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/13/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit

protocol CreateYourPlayListViewDelegate: class {
    func createSuccessReloadData()
}

class CreateYourPlayListViewController: BaseViewController {

    // MARK: - UI Elements
    
    weak var delegate: CreateYourPlayListViewDelegate?
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: FontSize.title.rawValue, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = TextManager.namePlayList
        return label
    }()
    
    fileprivate lazy var namePlayListTextField: PaddingTextField = {
        let textField = PaddingTextField()
        textField.attributedPlaceholder = NSAttributedString(string:TextManager.yourPlayList,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.layer.masksToBounds = true
        textField.textAlignment = .center
        textField.textColor = UIColor.white
        textField.font = UIFont.systemFont(ofSize: FontSize.superHeadline.rawValue, weight: .bold)
        textField.becomeFirstResponder()
        return textField
    }()
    
    fileprivate lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextManager.create.uppercased(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize.h1.rawValue, weight: .semibold)
        button.setTitleColor(UIColor.black, for: .normal)
        button.contentHorizontalAlignment = .center
        button.layer.cornerRadius = 25
        button.backgroundColor = UIColor.white
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(getAPICreatePlayListMe), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - View LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setRightNavigationBar(ImageManager.close)
        layoutTitleLabel()
        layoutNamePlayListTextField()
        layoutCreateButton()
    }
    
    @objc private func getAPICreatePlayListMe() {
        guard let newPlayList = namePlayListTextField.text else { return }
        let params = ["playlistName": newPlayList]
        let endPoint = SongEndPoint.createPlayList(bodyParams: params)
        showLoading()
        APIService.request(endPoint: endPoint) { (apiResponse) in
            if apiResponse.flag == true {
                AlertManager.shared.showToast(message: "Khởi tạo thành công")
                self.hideLoading()
                self.dismiss(animated: true) {
                    self.delegate?.createSuccessReloadData()
                }
            }
        } onFailure: { (serviceError) in
            self.hideLoading()
        } onRequestFail: {
            self.hideLoading()
        }
    }
    
    private func reloadDataWhenFinishLoadAPI() {
        self.hideLoading()
        self.isRequestingAPI = false
    }

    
    override func touchUpInRightBarButtonItem() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func layoutTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(Dimension.shared.largeMargin_120)
            make.centerX.equalToSuperview()
            make.width.equalTo(Dimension.shared.widthLabelLarge_300)
        }
    }
    
    private func layoutNamePlayListTextField() {
        view.addSubview(namePlayListTextField)
        namePlayListTextField.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(Dimension.shared.largeMargin_30)
            make.right.equalToSuperview().offset(-Dimension.shared.largeMargin_30)
            make.top.equalTo(titleLabel.snp.bottom).offset(Dimension.shared.largeMargin_50)
        }
    }
    
    private func layoutCreateButton() {
        view.addSubview(createButton)
        createButton.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.width.equalTo(Dimension.shared.largeWidthButton)
            make.centerX.equalToSuperview()
            make.top.equalTo(namePlayListTextField.snp.bottom).offset(Dimension.shared.normalMargin)
        }
    }

}
