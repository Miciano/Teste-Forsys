//
//  PullRequestsViewController.swift
//  AppGitHub
//
//  Created by Fabio Miciano on 16/02/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation
import UIKit

class PullRequestsViewController: UITableViewController {
    
    var urlPull: String?
    
    lazy var requests = {
        return RequestService()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
