//
//  PlayList.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/20/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import Foundation

struct PlayList {
    var title: String
    var image : String
    init(dictionary : [String : Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.image = dictionary["image"] as? String ?? ""
    }   
}
