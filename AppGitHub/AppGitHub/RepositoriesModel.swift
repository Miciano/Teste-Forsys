//
//  RepositoriesModel.swift
//  AppGitHub
//
//  Created by Fabio Miciano on 15/02/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation

struct RepositoriesModel {
    
    let id: Int
    let name: String
    let owner: OwnerModel?
    let pullsURL: String
    let forks: Int
    let stargazersCount: Int
    let description: String
    
    init(info: [String: Any]) throws {
        guard let id = info.idKey,
            let name = info.nameKey,
            let ownerInfo = info.ownerKey,
            let pullsURL = info.pullsUrlsKey,
            let stargazersCount = info.startsCountKey,
            let forks = info.forksCountKey,
            let description = info.descriptionKey else {
                throw ParseErros.invalidInput
        }
        
        self.owner = try? OwnerModel(info: ownerInfo)
        
        self.id = id
        self.name = name
        self.pullsURL = pullsURL
        self.forks = forks
        self.stargazersCount = stargazersCount
        self.description = description
    }
}
