//
//  PullRequestsViewController.swift
//  AppGitHub
//
//  Created by Fabio Miciano on 16/02/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation
import UIKit
import KVNProgress

class PullRequestsViewController: UITableViewController {
    
    var urlPull: String?
    var dataSource: [PullModel]?
    
    lazy var requests = {
        return RequestService()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Adiciono o refreshControll a tabela
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        if let refreshControl = refreshControl {
            tableView.addSubview(refreshControl)
        }
        //Adiciono a Celula Empty na referencia da tabela
        tableView.register(UINib(nibName: "EmptyCell", bundle: nil), forCellReuseIdentifier: "empty")
        
        KVNProgress.show(withStatus: "Carregando...")
        
        //Caso tenha uma URL faço o load dos PullsRequests
        if let urlPull = urlPull, urlPull != "" {
            loadPulls(url: urlPull)
        }
    }
    
    //PRAGMA MARK: -- TABLEVIEW DATA SOURCE --
    //Seta o numero de celulas que a tabela vai ter
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataSource = dataSource else { return 0 }
        return dataSource.count
    }
    
    //Retorna as celulas usadas
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let pull = dataSource?[indexPath.row],
            let cell = tableView.dequeueReusableCell(withIdentifier: "pullCell") as? PullCell else {
            //Se der erro ao achar a celula de pull ou no unwrap do dataSource eu retorno uma celula vazia
            return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath)
        }
        
        //Preencho os valores
        cell.configureCell(titlePull: pull.title, bodyPull: pull.body, userName: pull.user?.login, statusPull: pull.status, avatarURL: pull.user?.avatarUrl)
        
        return cell
    }
    
    //PRAGMA MARK: -- TABLE VIEW DELEGATE --
    //Evento chamado ao selecionar uma celula
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Faço animação para tirar a seleção
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //PRAGMA MARK: -- FUNCOES PRIVADAS --
    //Função faz o request dos PullRequests
    fileprivate func loadPulls(url: String) {
        
        //Faço o request e trato os erros
        requests.loadPullRequest(url: url) { (response) in
            
            //Se o refreshControl estiver na tela eu removo ele
            if self.refreshControl?.isRefreshing == true { self.refreshControl?.endRefreshing() }
            KVNProgress.dismiss()
            
            switch response {
            case .success(let model):
                self.dataSource = model
                self.tableView.reloadData()
            case .noConnection(let description):
                UIAlertController.alert(title: "Atenção", message: description.description, presenter: self, cancelButton: false, handler: nil)
            case .timeOut(let description):
                UIAlertController.alert(title: "Atenção", message: description.description, presenter: self, cancelButton: false, handler: { _ in
                    KVNProgress.show(withStatus: "Carregando...")
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
    
    //Função usada para atualziar a tabela quando acionado o refreshControl
    func refreshAction() {
        //Limpo todas as variaveis de controle
        dataSource = nil
        //Se tiver uma URL faço o request dos Pulls
        if let urlPull = urlPull, urlPull != "" { loadPulls(url: urlPull) }
    }
}
