//
//  APIService.swift
//  ArticlesApp
//
//  Created by DangTrungHieu on 4/11/20.
//  Copyright © 2020 DangTrungHieu. All rights reserved.
//

import Foundation
import Alamofire

public final class APIService<EndPoint: EndPointType> {
    
    
    static func request(endPoint: EndPoint,
                        onSuccess: @escaping ((APIResponse) -> Void),
                        onFailure: @escaping (ServiceErrorAPI?) -> Void,
                        onRequestFail: @escaping () -> Void) {
        
        var encoding: ParameterEncoding
        if (endPoint.httpMethod == .post || endPoint.httpMethod == .put) {
            encoding = JSONEncoding.default
        } else {
            encoding = URLEncoding.default
        }
        let dataRequest = SessionManager.default.request(endPoint.baseURL,
                                                         method: endPoint.httpMethod,
                                                         parameters: endPoint.parameters,
                                                         encoding: encoding,
                                                         headers: endPoint.headers)
        processResponse(dataRequest: dataRequest,
                        onSuccess: onSuccess,
                        onFailure: onFailure,
                        onRequestFail: onRequestFail)
    }
    
    private static func processResponse(dataRequest: DataRequest,
                                        onSuccess: @escaping ((APIResponse) -> Void),
                                        onFailure: @escaping (ServiceErrorAPI?) -> Void,
                                        onRequestFail: @escaping () -> Void) {
        
        dataRequest.responseData { (dataResponse) in

            if dataResponse.response?.isSuccess ?? false {
                let apiResponse = APIResponse(response: dataResponse)
                if apiResponse.data != nil {
                    onSuccess(apiResponse)
                } else {
                    onFailure(apiResponse.error)
                }
            } else {
                onRequestFail()
            }
        }
    }
    
    
}

extension Request {
    public func debugLog() -> Self {
        #if DEBUG
        debugPrint(self)
        #endif
        return self
    }
}
