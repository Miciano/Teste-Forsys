//
//  PullModel.swift
//  AppGitHub
//
//  Created by Fabio Miciano on 16/02/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation

struct PullModel {
    
    //PRAGMA MARK: -- PROPRIEDADES --
    let id: Int
    let status: String
    let title: String
    let body: String
    let user: OwnerModel?
    
    //PRAGMA MARK: -- PARSE --
    init(info: [String: Any]) throws {
        //Faço o parse utilizando da extension de dicionario, caso tenha algum problema retorno um erro
        guard let id = info.idKey,
        let status = info.statusKey,
        let title = info.titlekey,
        let body = info.bodyKey,
        let userInfo = info.userKey else {
             throw ParseErros.invalidInput
        }
        
        //Preencho os valores das propriedades
        self.user = try? OwnerModel(info: userInfo)
        
        self.id = id
        self.status = status
        self.title = title
        self.body = body
    }
}
