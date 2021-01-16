//
//  AppDelegate.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 9/23/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage
import IQKeyboardManagerSwift

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        UITabBar.appearance().barTintColor = UIColor.background
        UINavigationBar.appearance().barStyle = .blackOpaque
        
        if UserManager.isLoggedIn() {
            UserManager.getUserProfile()
            window?.rootViewController = ZTabBarViewController()
        } else {
            let signInVC = SignInViewController()
            window?.rootViewController = UINavigationController(rootViewController: signInVC)
        }
        return true
    }

}

