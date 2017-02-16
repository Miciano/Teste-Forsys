//
//  OwnerModel.swift
//  AppGitHub
//
//  Created by Fabio Miciano on 15/02/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation

struct OwnerModel {
    
    //PRAGMA MARK: -- PROPRIEDADES --
    let login: String
    let avatarUrl: String
    
    //PRAGMA MARK: -- PARSE --
    init(info: [String: Any]) throws {
        //Faço o parse utilizando da extension de dicionario, caso tenha algum problema retorno um erro
        guard let login = info.loginKey,
            let avatarUrl = info.avatarUrlKey else {
                throw ParseErros.invalidInput
        }
        
        //Preencho os valores das propriedades
        self.login = login
        self.avatarUrl = avatarUrl
    }
    
}
