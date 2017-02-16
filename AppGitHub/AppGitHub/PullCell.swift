//
//  PullCell.swift
//  AppGitHub
//
//  Created by Fabio Miciano on 16/02/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation
import UIKit

class PullCell: UITableViewCell {
    
    //PRAGMA MARK: -- OUTLETS --
    @IBOutlet weak var titlePull: UILabel!
    @IBOutlet weak var bodyPull: UILabel!
    @IBOutlet weak var imageProfile: ImageProfile!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var statusPull: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //Função preenche os Outlets e seta o visual da celula
    func configureCell(titlePull: String?, bodyPull: String?, userName: String?, statusPull: String?, avatarURL: String?) {
        
        //Preencho os outlets com os valores passados
        self.titlePull.text = titlePull
        self.bodyPull.text = bodyPull
        self.userName.text = userName
        if let statusPull = statusPull, statusPull != "" {
            self.statusPull.text = "Status: \(statusPull)"
        }
        
        //Carrego a imagem, caso tenha erro escondo a view
        imageProfile.createPhoto(with: avatarURL) { _ in
            self.imageProfile.isHidden = true
        }
    }
}
