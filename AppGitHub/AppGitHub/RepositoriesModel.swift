//
//  RepositoriesModel.swift
//  AppGitHub
//
//  Created by Fabio Miciano on 15/02/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation

struct RepositoriesModel {
    
    //PRAGMA MARK: -- PROPRIEDADES --
    let id: Int
    let name: String
    let owner: OwnerModel?
    let pullsURL: String
    let forks: Int
    let stargazersCount: Int
    let description: String
    
    //PRAGMA MARK: -- PARSE --
    init(info: [String: Any]) throws {
        //Faço o parse utilizando da extension de dicionario, caso tenha algum problema retorno um erro
        guard let id = info.idKey,
            let name = info.nameKey,
            let ownerInfo = info.ownerKey,
            let pullsURL = info.pullsUrlsKey,
            let stargazersCount = info.startsCountKey,
            let forks = info.forksCountKey,
            let description = info.descriptionKey else {
                throw ParseErros.invalidInput
        }
        
        //Preencho os valores das propriedades
        self.owner = try? OwnerModel(info: ownerInfo)
        
        self.id = id
        self.name = name
        self.pullsURL = pullsURL
        self.forks = forks
        self.stargazersCount = stargazersCount
        self.description = description
    }
}
