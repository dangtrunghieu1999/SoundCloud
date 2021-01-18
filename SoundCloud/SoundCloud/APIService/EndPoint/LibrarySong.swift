//
//  LibrarySong.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/18/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//
import Foundation
import Alamofire

enum LibrarySong {
    case addSongFavorite(param: Parameters)
}

extension LibrarySong: EndPointType {
    var path: String {
        switch self {
        case .addSongFavorite:
            return "/me/favorite"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .addSongFavorite:
            return .post
        }
        
    }
    
    var parameters: Parameters? {
        switch self {
        case .addSongFavorite(let params):
            return params
        }
    }
}
