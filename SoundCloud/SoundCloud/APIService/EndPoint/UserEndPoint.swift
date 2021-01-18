//
//  UserEndPoint.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/10/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit
import Alamofire

enum UserEndPoint {
    case signIn(bodyParams: Parameters)
    case signUp(bodyParams: Parameters)
    case forgotPW(bodyParams: Parameters)
    case checkValidCode(bodyParams: Parameters)
    case createNewPW(bodyParams: Parameters)
    case getUserById(bodyParams: Parameters)
    case searchUser(params: Parameters)
}

extension UserEndPoint: EndPointType {
    var path: String {
        switch self {
        case .signIn:
            return "/auth/login"
        case .signUp:
            return "/auth/signup"
        case .forgotPW:
            return "/User/ForgotPassword"
        case .checkValidCode:
            return "/User/ConfirmAccount"
        case .createNewPW:
            return "/User/CreateNewPassword"
        case .getUserById:
            return "/user/profile"
        case .searchUser:
            return "/User/SearchUser"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .signIn:
            return .post
        case .signUp:
            return .post
        case .forgotPW:
            return .post
        case .checkValidCode:
            return .post
        case .createNewPW:
            return .post
        case .getUserById:
            return .get
        case .searchUser:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .signIn(let bodyParams):
            return bodyParams
        case .signUp(let bodyParams):
            return bodyParams
        case .forgotPW(let bodyParams):
            return bodyParams
        case .checkValidCode(let bodyParams):
            return bodyParams
        case .createNewPW(let bodyParams):
            return bodyParams
        case .getUserById(let bodyParams):
            return bodyParams
        case .searchUser(let params):
            return params
        }
    }

}
