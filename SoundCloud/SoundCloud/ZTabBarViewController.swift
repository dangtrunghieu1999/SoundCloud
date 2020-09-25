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
        view.backgroundColor = UIColor.white
        tabBar.tintColor = UIColor.background
        
        let insets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let homeNavigationVC = UINavigationController(rootViewController: HomeViewController())
        homeNavigationVC.tabBarItem = UITabBarItem(title: nil, image: ImageManager.home_icon, tag: 0)
        homeNavigationVC.tabBarItem.imageInsets = insets
        
        let musicNavigationVC = UINavigationController(rootViewController: MusicViewController())
        musicNavigationVC.tabBarItem = UITabBarItem(title: nil, image: ImageManager.music, tag: 1)
        musicNavigationVC.tabBarItem.imageInsets = insets
        
        let searchNavigationVC = UINavigationController(rootViewController: SearchViewController())
        searchNavigationVC.tabBarItem = UITabBarItem(title: nil, image: ImageManager.search, tag: 2)
        searchNavigationVC.tabBarItem.imageInsets = insets
        
        let profileNavigationVC = UINavigationController(rootViewController: ProfileViewController())
        profileNavigationVC.tabBarItem = UITabBarItem(title: nil, image: ImageManager.profile, tag: 3)
        profileNavigationVC.tabBarItem.imageInsets = insets
        
        viewControllers = [homeNavigationVC, musicNavigationVC, searchNavigationVC, profileNavigationVC]
        
    }

}

