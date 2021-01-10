//
//  SignInViewModel.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/10/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import Foundation
import Alamofire

class SignInViewModel: BaseViewModel {
    
    // MARK: - Variables
    
    // MARK: - LifeCycles
    
    override func initialize() {}
    
    // MARK: - Public methods
    
    func canSignIn(userName: String?, passWord: String?) -> Bool {
        return (userName != nil && userName != "" && passWord != nil && passWord != "")
    }
    
    func requestSignIn(userName: String,
                       passWord: String,
                       onSuccess: @escaping () -> Void,
                       onError: @escaping (String) -> Void) {
        
        let params = ["UserName": userName, "Password": passWord]
        let endPoint = UserEndPoint.signIn(bodyParams: params)
        
        APIService.request(endPoint: endPoint, onSuccess: { (apiResponse) in
            guard apiResponse.data != nil else {
                onError(TextManager.accNotActive)
                return
            }
            
            if let user = apiResponse.toObject(User.self) {
                UserManager.saveCurrentUser(user)
                UserManager.getUserProfile()
                onSuccess()
            } else {
                onError(TextManager.errorMessage)
            }
        }, onFailure: { [weak self] (serviceError) in
            if serviceError?.message == "Account is inactive!" {
                if userName.isPhoneNumber {
                    // If user not active and is phone number
                    // will call API to trigger send OTP
                    // Then will navigate to Verity OTP ViewController
                    self?.triggerSendPhoneNumberOTPCode(userName: userName,
                                                        password: passWord,
                                                        onSuccess: onSuccess,
                                                        onError: onError)
                } else {
                    onError(TextManager.accNotActive)
                }
            } else {
                onError(TextManager.loginFailMessage)
            }
            
        }) {
            onError(TextManager.errorMessage)
        }
    }
    
    func triggerSendPhoneNumberOTPCode(userName: String,
                                       password: String,
                                       onSuccess: @escaping () -> Void,
                                       onError: @escaping (String) -> Void) {
        let endPoint: UserEndPoint = UserEndPoint.forgotPW(bodyParams: ["PhoneNumber": userName])
        
        APIService.request(endPoint: endPoint, onSuccess: { (apiResponse) in
            guard let userId = apiResponse.data?.dictionaryValue["UserId"]?.stringValue else {
                #if DEBUG
                fatalError("TRIEUND > ForgotPW Request OTP > UserId Nil")
                #else
                return
                #endif
            }
            
            if let topViewController = UIViewController.topViewController() as? BaseViewController {
                topViewController.hideLoading()
            }
            
            UserSessionManager.shared.saveUserId(userId)
//            AppRouter.pushToVerifyOTPVC(with: userName, isActiveAcc: true)
            
            }, onFailure: { (serviceError) in
                onError(TextManager.invalidEmail)
        }) {
            onError(TextManager.errorMessage)
        }
    }
    
}
