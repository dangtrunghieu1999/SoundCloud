//
//  YourHomeViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/21/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class YourLibraryViewController: BaseViewController {
    
    // MARK: - Variables
    
    fileprivate lazy var song = [Song]()
    fileprivate lazy var playList = [YourPlayList]()
    fileprivate lazy var likeSong = [Song]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

