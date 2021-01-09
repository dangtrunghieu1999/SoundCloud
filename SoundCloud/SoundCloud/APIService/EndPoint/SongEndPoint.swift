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
    case getPlistSong
}

extension SongEndPoint: EndPointType {
    var path: String {
        switch self {
        case .getPlistSong:
            return "/get-list-recommend-song"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getPlistSong:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getPlistSong:
            return nil
        }
    }
    
    
}
