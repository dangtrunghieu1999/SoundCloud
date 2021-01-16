//
//  SongEndPoint.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/5/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import Foundation
import Alamofire

enum SongEndPoint {
    case getHomeSong
    case getPlistSongById(bodyParams: Parameters)
}

extension SongEndPoint: EndPointType {
    var path: String {
        switch self {
        case .getPlistSongById:
            return "/album/a"
        case .getHomeSong:
            return ""
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getPlistSongById:
            return .get
        case .getHomeSong:
            return .get
        }
        
    }
    
    var parameters: Parameters? {
        switch self {
        case .getPlistSongById(let params):
            return params
        case .getHomeSong:
            return nil
        }
    }
}
