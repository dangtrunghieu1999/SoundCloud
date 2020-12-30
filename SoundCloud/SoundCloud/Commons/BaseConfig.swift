//
//  BaseConfig.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/29/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import Foundation

protocol ParserData {
    func transformToDictionary() -> Dictionary<String, Any>
}


protocol BaseFirebaseNodeObjectProtocol {
    var uid: String { get set }
    
}

