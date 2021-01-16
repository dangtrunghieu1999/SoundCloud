//
//  PlayList.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/16/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit
import SwiftyJSON

class PlayList: NSObject,JSONParsable {
    var id                = ""
    var name              = ""
    var image             = ""
    var listSongs: [Any]  = []
    
    required init(json: JSON) {
        id              = json["_id"].stringValue
        name            = json["name"].stringValue
        image           = json["image"].stringValue
        listSongs       = json["listSongs"].arrayObject ?? []
    }
    
    required override init() {}
}
