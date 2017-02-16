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
    
    fileprivate var mainModel: MainRequestModel?
    fileprivate var dataSource: [RepositoriesModel] = []
    fileprivate var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        if let refreshControl = refreshControl {
            tableView.addSubview(refreshControl)
        }
        
        //loadRepositories()
    }
    
    //PRAGMA MARK: -- TABLEVIEW DATA SOURCE --
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mainModel?.total == dataSource.count ? dataSource.count : dataSource.count+1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == dataSource.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "loadCell") as? LoadCell else {
                return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath)
            }
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "repositorieCell") as? RepositoriesCell else {
            return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath)
        }
        
        let item = dataSource[indexPath.row]
        
        cell.configureCell(repositorieName: item.name, descriptionRepositorie: item.description, forks: item.forks, stars: item.stargazersCount, userName: item.owner?.login, urlAvatar: item.owner?.avatarUrl)
        
        return cell
    }
    
    //PRAGMA MAR: -- TABLE VIEE DELEGATE --
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == dataSource.count {
            loadRepositories()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    //PRAGMA MARK: -- FUNCOES PRIVADAS --
    fileprivate func loadRepositories() {
        
        page += 1
        request.loadRepositories(page: page) { (response) in
        
            if self.refreshControl?.isRefreshing == true { self.refreshControl?.endRefreshing() }
            
            switch response {
            case .success(let model):
                self.mainModel = model
                self.incrementDataSource()
            case .noConnection(let description):
                print("erro \(description)")
            case .timeOut(let description):
                self.tableView.reloadData()
                print("erro \(description)")
            case .serverError(let description):
                print("erro \(description)")
            case .invalidResponse:
                print("erro invalido")
            }
        }
    }
    
    fileprivate func incrementDataSource() {
     
        guard let items = mainModel?.items else { return }
        print("Datasoucer Count = \(dataSource.count)")
        for item in items {
            dataSource.append(item)
        }
        print("Datasoucer Count = \(dataSource.count)")
        self.tableView.reloadData()
    }
    
    func refreshAction() {
        page = 0
        mainModel = nil
        loadRepositories()
    }
}
