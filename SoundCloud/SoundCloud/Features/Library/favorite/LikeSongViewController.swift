//
//  LikeSongViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/14/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit

class LikeSongViewController: BaseViewController {

    fileprivate lazy var likeSong = [SongTrack]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    public func configData(likeSongs: [SongTrack]) {
        self.likeSong = likeSongs
    }
    
}
