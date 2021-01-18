//
//  SignUpViewModel.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/10/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit
import Alamofire

class SignUpViewModel: BaseViewModel {
    
    // MARK: - LifeCycles
    
    override func initialize() {}
    
    // MARK: - Public methods
    
    func canSignUp(email: String?,
                   password: String?,
                   userName: String?,
                   gender: Bool?) -> Bool {
        if (email != nil && email != ""  && (email?.isValidEmail ?? false)
            && userName != nil && userName != ""
            && password != nil && password != ""
            && gender != nil) {
            return true
        } else {
            return false
        }
    }
    
    
    func requestSignUp(email: String,
                       userName: String,
                       password: String,
                       gender: Bool,
                       onSuccess: @escaping () -> Void,
                       onError: @escaping (String) -> Void) {
        
        let params: [String: Any] = ["email": email,
                                     "fullname": userName,
                                     "password": password,
                                     "gender": gender]
        
        let endPoint = UserEndPoint.signUp(bodyParams: params)
        
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
        }, onFailure: { (apiError) in
            if userName.isValidEmail {
                onError(TextManager.existEmail)
            } else {
                onError(TextManager.existPhoneNumber)
            }
        }) {
            onError(TextManager.errorMessage)
        }
    }
    
}

