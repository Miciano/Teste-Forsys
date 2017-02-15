//
//  RepositoriesModel.swift
//  TesteForSys
//
//  Created by Fabio Miciano on 14/02/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation

struct RepositoriesModel {
    
    let id: Int
    let name: String
    let owner: OwnerModel
    let pullsURL: String
    let forks: Int
    let stargazersCount: Int
    let description: String
}
