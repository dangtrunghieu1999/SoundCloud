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
        
        let params = ["email": userName, "password": passWord]
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
        }, onFailure: { (apiError) in
            if userName.isValidEmail {
                onError(TextManager.loginFailMessage)
            } else {
                onError(TextManager.invalidEmail)
            }
        }) {
            onError(TextManager.loginFailMessage)
        }
    }
    
    
}
