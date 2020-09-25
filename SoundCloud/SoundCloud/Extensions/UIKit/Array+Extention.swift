//
//  Array+Extention.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 9/23/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        if index < count && index >= 0 {
            return self[index]
        } else {
            return nil
        }
    }
}
