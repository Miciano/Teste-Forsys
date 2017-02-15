//
//  OwnerModel.swift
//  AppGitHub
//
//  Created by Fabio Miciano on 15/02/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation

struct OwnerModel {
    
    let login: String
    let avatarUrl: String
    
    init(info: [String: Any]) throws {
        guard let login = info.loginKey,
            let avatarUrl = info.avatarUrlKey else {
                throw ParseErros.invalidInput
        }
        
        self.login = login
        self.avatarUrl = avatarUrl
    }
    
}
