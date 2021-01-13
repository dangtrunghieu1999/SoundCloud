//
//  SearchSongViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/12/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit

class SearchSongViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    private func setupNavBar() {
        navigationItem.titleView = searchBar
        self.setRightNavigationBar(ImageManager.cancel)
        searchBar.becomeFirstResponder()
        view.endEditing(true)
    }
    
    override func touchUpInRightBarButtonItem() {
        self.dismiss(animated: true, completion: nil)
    }
}


