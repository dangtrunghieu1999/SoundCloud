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
        if (email != nil && email != ""  && (email?.isPhoneNumber ?? false || email?.isValidEmail ?? false)
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
                       dob: Date,
                       onSuccess: @escaping () -> Void,
                       onError: @escaping (String) -> Void) {
        
        var params = ["UserType": "KH",
                      "Email": email,
                      "UserName": userName,
                      "Password": password,
                      "Birthday": dob.desciption(by: DateFormat.fullDateServerFormat)]
        if userName.isValidEmail {
            params["Email"] = userName
        } else if userName.isPhoneNumber {
            params["Email"] = "\(userName)@gmail.com"
            params["PhoneNumber"] = userName
        }
        
        let endPoint = UserEndPoint.signUp(bodyParams: params)
        
        APIService.request(endPoint: endPoint, onSuccess: { (apiResponse) in
            if let userId = apiResponse.data?.dictionaryValue["UserId"]?.stringValue {
                UserSessionManager.shared.saveUserId(userId)
            }
            onSuccess()
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

