//
//  UILabel+Extension.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/2/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit
import AVFoundation

extension UILabel {
    func setDecimalText(numberText number: Int, header: String, footer: String) {
        if number == 0 {
            self.text = ""
            return
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let doubelText = Double(number)
        
        let numberDecimal =  numberFormatter.string(from: NSNumber(value: doubelText))
        guard let decimal = numberDecimal else {
            self.text = "\(header)... \(footer)"
            return
        }
        self.text = "\(header) \(decimal) \(footer)"
        
    }
    
    func getTimeFromCMTime(_ time: CMTime) {
        let timeConfig = CMTimeGetSeconds(time)
        guard !(timeConfig.isNaN || timeConfig.isInfinite) else {
            return
        }
        
        let timeSecond = Int(timeConfig)
        let minute = timeSecond / 60
        let second = timeSecond % 60
        var strMinute:String = ""
        var strSecond:String = ""
        
        if minute < 10 {
            strMinute = "0\(minute)"
        }
        else {
            strMinute = "\(minute)"
        }
        if second < 10 {
            strSecond = "0\(second)"
        }
        else {
            strSecond = "\(second)"
        }
        self.text = "\(strMinute):\(strSecond)"
    }
}
