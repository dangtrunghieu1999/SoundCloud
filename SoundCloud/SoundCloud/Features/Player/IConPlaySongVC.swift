//
//  IConPlaySongVC.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/2/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit

enum IConPlaySongVC: String {
    case thumbImage     = "ThumbImage"
    case playIcon       = "PlayIcon"
    case pauseIcon      = "PauseIcon"
    case nextIcon       = "NextIcon"
    case backIcon       = "BackIcon"
    case repeatIcon     = "RepeatIcon"
    case shuffleIcon    = "ShuffleIcon"
    case shareIcon      = "ShareIcon"
    case deviceIcon     = "DeviceIcon"
}

extension IConPlaySongVC {
    var image: UIImage {
        return UIImage(named: self.rawValue)!
    }
}

