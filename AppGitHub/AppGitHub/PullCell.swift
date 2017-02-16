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
    @IBOutlet weak var titlePull: UILabel!
    @IBOutlet weak var bodyPull: UILabel!
    @IBOutlet weak var imageProfile: ImageProfile!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var statusPull: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(titlePull: String?, bodyPull: String?, userName: String?, statusPull: String?, avatarURL: String?) {
        
        self.titlePull.text = titlePull
        self.bodyPull.text = bodyPull
        self.userName.text = userName
        if let statusPull = statusPull, statusPull != "" {
            self.statusPull.text = "Status: \(statusPull)"
        }
        
        imageProfile.createPhoto(with: avatarURL) { _ in
            self.imageProfile.isHidden = true
        }
    }
}
