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
    
    //PRAGMA MARK: -- VARIAVEIS PRIVADAS --
    //Guarda os models usados para preencher a tabela
    fileprivate var mainModel: MainRequestModel?
    fileprivate var dataSource: [RepositoriesModel] = []
    //Cuida da página que deve ser carregada
    fileprivate var page = 0
    //guarda os valores que serão passados para tela de PullRequests
    fileprivate var urlPullSelected: String?
    fileprivate var nameRepositorieSelected: String?
    
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
    }
    
    //Função usada para preparar a troca de telas
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Faço o unwrap da view
        guard let view = segue.destination as? PullRequestsViewController else { return }
        //Seto os valores de suas propriedades
        view.urlPull = urlPullSelected
        view.requests = request
        //Seto o titulo da viewController
        view.title = nameRepositorieSelected
        //Mudo o texto do botão de back para Voltar
        let backButton = UIBarButtonItem()
        backButton.title = "Voltar"
        navigationItem.backBarButtonItem = backButton
    }
    
    //PRAGMA MARK: -- TABLEVIEW DATA SOURCE --
    //Seta o numero de celulas que a tabela vai ter
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Caso o dataSource não tenha alcaçado o numeo maximo retorno um +1 que vai ser a celula de load
        return mainModel?.total == dataSource.count ? dataSource.count : dataSource.count+1
    }
    //Retorna as celulas usadas
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Se for a ultima celula retorno a celula de load
        if indexPath.row == dataSource.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "loadCell") as? LoadCell else {
                return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath)
            }
            cell.activity.startAnimating()
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "repositorieCell") as? RepositoriesCell else {
            //Se der erro ao achar a celula de repositorio eu retorno uma celula vazia
            return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath)
        }
        
        //Pego o item referente a celula
        let item = dataSource[indexPath.row]
        
        //Preencho os valores
        cell.configureCell(repositorieName: item.name, descriptionRepositorie: item.description, forks: item.forks, stars: item.stargazersCount, userName: item.owner?.login, urlAvatar: item.owner?.avatarUrl, pullURL: item.pullsURL)
        
        return cell
    }
    
    //PRAGMA MARK: -- TABLE VIEW DELEGATE --
    //Evento chamado quando uma celula entra na tela
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //Se for a ultima celula carrega masis repositorios
        if indexPath.row == dataSource.count {
            loadRepositories()
        }
    }
    
    //Seta o tamanho das celulas
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    //Evento chamado ao selecionar uma celula
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Faço animação para tirar a seleção
        tableView.deselectRow(at: indexPath, animated: true)
        //Pego a celula que foi tocada
        guard let cell = tableView.cellForRow(at: indexPath) as? RepositoriesCell else { return }
        //Preencho minhas variaveis de controle
        self.urlPullSelected = cell.pullURL
        self.nameRepositorieSelected = cell.repositorieName.text
        //Faço a troca de tela
        performSegue(withIdentifier: "pullsList", sender: self)
    }
    
    //PRAGMA MARK: -- FUNCOES PRIVADAS --
    //Função faz o request dos repositorios
    fileprivate func loadRepositories() {
        
        page += 1
        //Faço o request e trato os erros
        request.loadRepositories(page: page) { (response) in
        
            //Se o refreshControl estiver na tela eu removo ele
            if self.refreshControl?.isRefreshing == true { self.refreshControl?.endRefreshing() }
            
            switch response {
            case .success(let model):
                //Preencho o mainModel e incremento os resultados no dataSource
                self.mainModel = model
                self.incrementDataSource()
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
    
    //Função usada para incrementar o dataSource
    fileprivate func incrementDataSource() {
     
        //Faço unwrap dos items
        guard let items = mainModel?.items else { return }
        //Adiciono os items no dataSource
        for item in items {
            dataSource.append(item)
        }
        //Falo para tabela se recarregar
        self.tableView.reloadData()
    }
    
    //Função usada para atualziar a tabela quando acionado o refreshControl
    func refreshAction() {
        //Limpo todas as variaveis de controle
        page = 0
        mainModel = nil
        dataSource.removeAll()
        //Peço para recarregar
        loadRepositories()
    }
}
