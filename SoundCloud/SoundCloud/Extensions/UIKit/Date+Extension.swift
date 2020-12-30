//
//  Date+Extension.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/29/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

extension Date {
    var serverDateFormat: String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        return dateFormater.string(from: self)
    }
    
    func desciption(by format: DateFormat) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = format.rawValue
        return dateFormater.string(from: self)
    }
    
    var pretyDesciption: String {
        let dateFormatter       = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        dateFormatter.locale    = Locale(identifier: "vi_VN")
        return dateFormatter.string(from: self)
    }
}

