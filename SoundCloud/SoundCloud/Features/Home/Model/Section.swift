//
//  Section.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/20/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import Foundation

struct SectionTitle {    
    var title : String
    var playlists : NSArray
    init(dictionary:[String : Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.playlists = dictionary["playlists"] as? NSArray ?? []
    }
}
