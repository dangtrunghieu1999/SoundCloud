//
//  TrackModel.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/3/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class TrackModel {
     private (set) var imageTrack = [UIImage(named: "dance"), UIImage(named: "rock"),
                            UIImage(named: "indie"), UIImage(named: "chilled"),
                            UIImage(named: "electronic"), UIImage(named: "arebe")]
     private (set) var nameTrack  = ["Dance & EDM", "Country Rocks", "Indie", "Chilled Hits", "Electronic","Are & Be"]
    
     private (set) var songTrack = [UIImage(named: "study"), UIImage(named: "chillfolk"),
                                    UIImage(named: "hits"),UIImage(named: "study"), UIImage(named: "chillfolk"),
                                    UIImage(named: "hits")]
    
     private (set) var songName  = ["Chilled Hits", "Study Beats", "Chill As Folk","Chilled Hits", "Study Beats", "Chill As Folk"]
    
}
