//
//  AnimatePlayVCHelper.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/1/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit

enum Direction: String {
    case up = "up"
    case down = "down"
    case left = "left"
    case right = "right"
    case none = ""
}

enum StatePlaySong: String {
    case full = "full"
    case minimum = "minimum"
    case dissmissLeft = "dissmissLeft"
    case dissmissRight = "dissmissRight"
    case none = ""
}
