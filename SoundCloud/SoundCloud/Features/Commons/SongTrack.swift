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
    
    var title               = ""
    var genre               = ""
    var views               = ""
    var path                = ""
    var image               = ""
    var id                  = ""
    var listArtists: [Any]  = []
    required override init() {}
    
    
    required init(json: JSON) {
        id              = json["_id"].stringValue
        title           = json["title"].stringValue
        genre           = json["genre"].stringValue
        path            = json["path"].stringValue
        image           = json["image"].stringValue
        views           = json["views"].stringValue
        listArtists     = json["listArtists"].arrayObject ?? []
    }
    
}

