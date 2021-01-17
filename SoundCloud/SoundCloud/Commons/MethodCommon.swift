//
//  MethodCommon.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/17/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit

class CommonMethod {

    static func convertArrayToStringText(data:[Any]) -> String {
        let arrayOfStrings: [String] = data.compactMap { String(describing: $0) }
        let artist = arrayOfStrings.joined(separator: "-")
        return artist
    }
}
