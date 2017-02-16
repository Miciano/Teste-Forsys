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
    
    var dataSource: [PullModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        
        if let refreshControl = refreshControl {
            tableView.addSubview(refreshControl)
        }
        
        tableView.register(UINib(nibName: "EmptyCell", bundle: nil), forCellReuseIdentifier: "empty")
        
        if let urlPull = urlPull, urlPull != "" {
            loadPulls(url: urlPull)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataSource = dataSource else { return 0 }
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let pull = dataSource?[indexPath.row],
            let cell = tableView.dequeueReusableCell(withIdentifier: "pullCell") as? PullCell else {
            return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath)
        }
        
        cell.configureCell(titlePull: pull.title, bodyPull: pull.body, userName: pull.user?.login, statusPull: pull.status, avatarURL: pull.user?.avatarUrl)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    fileprivate func loadPulls(url: String) {
        
        requests.loadPullRequest(url: url) { (response) in
            
            if self.refreshControl?.isRefreshing == true { self.refreshControl?.endRefreshing() }
            
            switch response {
            case .success(let model):
                self.dataSource = model
                self.tableView.reloadData()
            case .noConnection(let description):
                UIAlertController.alert(title: "Atenção", message: description.description, presenter: self, cancelButton: false, handler: nil)
            case .timeOut(let description):
                UIAlertController.alert(title: "Atenção", message: description.description, presenter: self, cancelButton: false, handler: { _ in
                    self.refreshAction()
                })
            case .serverError(let description):
                UIAlertController.alert(title: "Erro \(description.statusCode)", message: description.description, presenter: self, cancelButton: false, handler: nil)
            case .invalidResponse:
                UIAlertController.alert(title: "Erro", message: "Não prevemos esse caso, irei causar um fatalError", presenter: self, cancelButton: false, handler: {_ in
                    fatalError("erro invalido")
                })
            }
        }
    }
    
    func refreshAction() {
        dataSource = nil
        if let urlPull = urlPull, urlPull != "" { loadPulls(url: urlPull) }
    }
}
