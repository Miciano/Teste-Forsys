//
//  RepositoriesViewController.swift
//  AppGitHub
//
//  Created by Fabio Miciano on 15/02/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation
import UIKit

class RepositoriesViewController: UITableViewController {
    
    lazy var request = {
        return RequestService()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        request.loadRepositories(page: 1)
        { (response) in
            
            switch response {
            case .success(let model):
                print("model = \(model)")
            case .noConnection(let description):
                print("erro \(description)")
            case .timeOut(let description):
                print("erro \(description)")
            case .serverError(let description):
                print("erro \(description)")
            case .invalidResponse:
                print("erro invalido")
            }
        }
    }
}
