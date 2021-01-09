//
//  ZTabBarViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 9/25/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class ZTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainBackground
        self.tabBar.tintColor = UIColor.white
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        
        let insets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let homeNavigationVC = UINavigationController(rootViewController: AlbumViewController())
        homeNavigationVC.tabBarItem = UITabBarItem(title: nil, image: ImageManager.home, tag: 0)
        homeNavigationVC.tabBarItem.imageInsets = insets
        
        let searchNavigationVC = UINavigationController(rootViewController: SearchViewController())
        searchNavigationVC.tabBarItem = UITabBarItem(title: nil, image: ImageManager.search, tag: 1)
        searchNavigationVC.tabBarItem.imageInsets = insets
        
        let yourLibraryNavigationVC = UINavigationController(rootViewController: YourLibraryViewController())
        yourLibraryNavigationVC.tabBarItem = UITabBarItem(title: nil, image: ImageManager.library, tag: 2)
        yourLibraryNavigationVC.tabBarItem.imageInsets = insets
        
        viewControllers = [homeNavigationVC, searchNavigationVC, yourLibraryNavigationVC]
        
    }

}

