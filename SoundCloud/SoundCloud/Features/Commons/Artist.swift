//
//  Artist.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/14/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit
import SwiftyJSON

class Artist:NSObject, JSONParsable  {

    var id              = ""
    var fullName        = ""
    var gender          = ""
    
    required init(json: JSON) {
        
    }
    
    required override init() {}
}
