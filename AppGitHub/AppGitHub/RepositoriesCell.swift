//
//  RepositoriesCell.swift
//  AppGitHub
//
//  Created by Fabio Miciano on 16/02/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation
import UIKit

class RepositoriesCell: UITableViewCell {
    
    //PRAGMA MARK: -- OUTLETS --
    @IBOutlet weak var repositorieName: UILabel!
    @IBOutlet weak var descriptionRepositorie: UILabel!
    @IBOutlet weak var forks: UILabel!
    @IBOutlet weak var stars: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var imageProfile: ImageProfile!
    
    //PRAGMA MARK: -- PROPRIEDADES --
    var pullURL: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //Função preenche os Outlets e seta o visual da celula
    func configureCell(repositorieName: String?, descriptionRepositorie: String?, forks: Int, stars: Int, userName: String?, urlAvatar: String?, pullURL: String?) {
        
        //Limpo a URL do pull e adiciono o parametro ?state=all para buscar todos os pullsRequests
        if let urlSplited = pullURL?.characters.split(separator: "{").map(String.init) {
            self.pullURL = "\(urlSplited[0])?state=all"
        }
        
        //Preencho os outlets com os valores passados
        self.repositorieName.text = repositorieName
        self.descriptionRepositorie.text = descriptionRepositorie
        self.forks.text = "\(forks)"
        self.stars.text = "\(stars)"
        self.userName.text = userName
        
        //Carrego a imagem, caso tenha erro escondo a view
        imageProfile.createPhoto(with: urlAvatar) { _ in
            self.imageProfile.isHidden = true
        }
    }
}
