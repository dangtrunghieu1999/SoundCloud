//
//  YourPlayList.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/13/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit
import SwiftyJSON

class YourPlayList: NSObject,JSONParsable {
    var id                = ""
    var title             = ""
    var listSongs: [Song]  = []
    
    required init(json: JSON) {
        id              = json["_id"].stringValue
        title           = json["title"].stringValue
        listSongs       = json["listSongs"].arrayValue.map{Song(json: $0)}
    }
    
    required override init() {}
}
