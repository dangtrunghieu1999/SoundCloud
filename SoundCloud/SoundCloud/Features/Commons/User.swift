//
//  User.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/10/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit
import SwiftyJSON

class User: NSObject, JSONParsable, NSCoding {
    
    var id              = ""
    var token           = ""
    var fullName        = ""
    var email           = ""
    var gender          :Bool?
    var listPlaylists: [Song] = []
    var listFavoriteSongs: [Song] = []
    
    required override init() {}

    required init(json: JSON) {
        self.id                = json["id"].stringValue
        self.token             = json["token"].stringValue
        self.fullName          = json["fullname"].stringValue
        self.email             = json["email"].stringValue
        self.gender            = json["gender"].boolValue
        self.listPlaylists     = json["listPlaylists"].arrayValue.map{Song(json: $0)}
        self.listFavoriteSongs = json["listFavoriteSongs"].arrayValue.map{Song(json: $0)}

    }
    
    required init?(coder aDecoder: NSCoder) {
        id                   = aDecoder.decodeObject(forKey: "id") as? String ?? ""
        token                = aDecoder.decodeObject(forKey: "token") as? String ?? ""
        fullName             = aDecoder.decodeObject(forKey: "fullname") as? String ?? ""
        email                = aDecoder.decodeObject(forKey: "email") as? String ?? ""
        gender               = aDecoder.decodeObject(forKey: "gender") as? Bool ?? true
        listPlaylists        = aDecoder.decodeObject(forKey: "listPlaylists") as? [Song] ?? []
        listFavoriteSongs    = aDecoder.decodeObject(forKey: "listPlaylists") as? [Song] ?? []
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id,           forKey: "id")
        aCoder.encode(token,        forKey: "auth")
        aCoder.encode(fullName,     forKey: "fullname")
        aCoder.encode(email,        forKey: "email")
        aCoder.encode(gender,       forKey: "gender")
        aCoder.encode(listPlaylists,forKey: "listPlaylists")
        aCoder.encode(listFavoriteSongs, forKey: "listFavoriteSongs")
    }
    
}
