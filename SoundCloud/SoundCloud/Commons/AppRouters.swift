//
//  AppRouters.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/1/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import Foundation
import UIKit
class AppRouter: NSObject {
    
    class func pushPlayList() {
        let viewController = AlbumViewController()
        UINavigationController.topNavigationVC?.pushViewController(viewController, animated: true)
    }
}
