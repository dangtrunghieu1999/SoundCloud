//
//  SongTrack.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/5/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SongTrack: NSObject, JSONParsable {
    
    var id              = ""
    var title           = ""
    var download_permit = ""
    var genre           = ""
    var path            = ""
    var image           = ""
    var album_id        = ""
    var artist_id       = ""
    
    required override init() {}
    
    
    required init(json: JSON) {
        id              = json["id"].stringValue
        title           = json["title"].stringValue
        download_permit = json["download_permit"].stringValue
        genre           = json["genre"].stringValue
        path            = json["path"].stringValue
        image           = json["image"].stringValue
        album_id        = json["album_id"].stringValue
        artist_id       = json["artist_id"].stringValue
    }
    
}

