//
//  SectionHome.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/16/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit
import SwiftyJSON

class SectionHome: NSObject, JSONParsable {
    
    var title                = ""
    var playlists:[PlayList] = []
    
    required init(json: JSON) {
        title               = json["title"].stringValue
        playlists           = json["playlists"].arrayValue.map{PlayList(json: $0)}
    }
    
    required override init() {}
    
}
