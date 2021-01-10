//
//  SettingViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 1/1/21.
//  Copyright © 2021 Dang Trung Hieu. All rights reserved.
//

import UIKit

class SettingViewController: BaseViewController {

    // MARK: - UI Elements
    
    fileprivate lazy var settingTableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    
    // MARK: - View LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = TextManager.setting
    }
    
}
