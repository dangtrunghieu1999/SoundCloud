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
    case getPlistSongById(param: Parameters)
    case getSearchSong(param: Parameters)
    case getFavoriteSong
    case getPlayListSong
    case createPlayList(bodyParams: Parameters)
}

extension SongEndPoint: EndPointType {
    var path: String {
        switch self {
        case .getPlistSongById:
            return "/album/a"
        case .getHomeSong:
            return ""
        case .getSearchSong:
            return "/search"
        case .getFavoriteSong:
            return "/me/favorite"
        case .getPlayListSong:
            return "/me/playlist"
        case .createPlayList:
            return "/me/playlist"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getPlistSongById:
            return .get
        case .getHomeSong:
            return .get
        case .getSearchSong:
            return .get
        case .getFavoriteSong:
            return .get
        case .getPlayListSong:
            return .get
        case .createPlayList:
            return .post
        }
        
    }
    
    var parameters: Parameters? {
        switch self {
        case .getPlistSongById(let params):
            return params
        case .getHomeSong:
            return nil
        case .getSearchSong(let param):
            return param
        case .getFavoriteSong:
            return nil
        case .getPlayListSong:
            return nil
        case .createPlayList(let bodyParams):
            return bodyParams
        }
    }
}
