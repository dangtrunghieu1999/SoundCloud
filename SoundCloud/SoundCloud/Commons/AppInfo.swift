//
//  AppInfo.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/10/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit

class AppInfo: NSObject {
    
    class func appDisplayName() -> String {
        let dipslayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
        return dipslayName
    }
    
    class func build() -> String {
        let version = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
        return version
    }
    
    class func version() -> String {
        let versionString = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        return versionString
    }
    
    class func bundleId() -> String {
        let bundleId = Bundle.main.object(forInfoDictionaryKey: kCFBundleIdentifierKey as String) as! String
        return bundleId
    }
    
    class func bundleName() -> String {
        let bundleName = Bundle.main.object(forInfoDictionaryKey: kCFBundleNameKey as String) as! String
        return bundleName
    }
    
    class func osversion() -> String {
        return UIDevice.current.systemVersion
    }
}
