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
    
    class func pushAlbumSongList(album: PlayList) {
        let viewController = AlbumViewController()
        viewController.album = album
        viewController.idAlbum = album.id
        UINavigationController.topNavigationVC?.pushViewController(viewController, animated: true)
    }
}
