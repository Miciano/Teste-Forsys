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
    
    @IBOutlet weak var repositorieName: UILabel!
    @IBOutlet weak var descriptionRepositorie: UILabel!
    @IBOutlet weak var forks: UILabel!
    @IBOutlet weak var stars: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var imageProfile: ImageProfile!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(repositorieName: String?, descriptionRepositorie: String?, forks: Int, stars: Int, userName: String?, urlAvatar: String?) {
        
        self.repositorieName.text = repositorieName
        self.descriptionRepositorie.text = descriptionRepositorie
        self.forks.text = "\(forks)"
        self.stars.text = "\(stars)"
        self.userName.text = userName
        
        imageProfile.createPhoto(with: urlAvatar, handlerSuccess: nil, handlerError: nil)
    }
}
