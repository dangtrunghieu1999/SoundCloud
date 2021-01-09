//
//  EndPointType.swift
//  ArticlesApp
//
//  Created by DangTrungHieu on 4/10/20.
//  Copyright © 2020 DangTrungHieu. All rights reserved.
//

import UIKit
import Alamofire

public protocol EndPointType {
    var enviromentBaseURL:  String                   { get }
    var baseURL:            URL                      { get }
    var path:               String                   { get }
    var httpMethod:         HTTPMethod               { get }
    var headers:            HTTPHeaders?             { get }
    var parameters:         Parameters?              { get }
    var cachePolicy:        NSURLRequest.CachePolicy { get }
}

// MARK: -

public extension EndPointType {
    var enviromentBaseURL: String {
        return APIConfig.baseURLString
    }
    
    var baseURL: URL {
        let urlString = enviromentBaseURL + path;
        guard let url = URL(string: urlString) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .useProtocolCachePolicy
    }
    
    var headers: HTTPHeaders? {
        let headers = ["Content-Type": "application/json"]
        return headers
    }
}
