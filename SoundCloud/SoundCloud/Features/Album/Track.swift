//
//  Track.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/1/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

struct Track {
    var imageName: String
    var title: String
    var artist: String
}

class TrackModel {
    static let tracks: [Track] = [Track(imageName: "2020", title: "Hãy trao cho anh", artist: "Sơn Tùng MTP"),
                                  Track(imageName: "2019", title: "Hãy trao cho anh", artist: "Sơn Tùng MTP"),
                                  Track(imageName: "40", title: "Hãy trao cho anh", artist: "Sơn Tùng MTP"),
                                  Track(imageName: "apollo", title: "Hãy trao cho anh", artist: "Sơn Tùng MTP"),
                                  Track(imageName: "eric", title: "Hãy trao cho anh", artist: "Sơn Tùng MTP"),
                                  Track(imageName: "halt", title: "Hãy trao cho anh", artist: "Sơn Tùng MTP"),
                                  Track(imageName: "live", title: "Hãy trao cho anh", artist: "Sơn Tùng MTP"),
                                  Track(imageName: "masters", title: "Hãy trao cho anh", artist: "Sơn Tùng MTP"),
                                  Track(imageName: "todd", title: "Hãy trao cho anh", artist: "Sơn Tùng MTP"),
    ]
}
