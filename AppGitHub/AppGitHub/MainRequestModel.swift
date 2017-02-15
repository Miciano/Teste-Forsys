//
//  MainRequestModel.swift
//  AppGitHub
//
//  Created by Fabio Miciano on 15/02/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation

struct MainRequestModel {
    
    let total: Int
    let incompleteResults: Bool
    let items: [RepositoriesModel]?
    
    init(info: [String: Any]) throws {
        guard let total = info.totalCountKey,
            let incompleteResults = info.incompleteResultsKey,
            let itemsInfo = info.itemsKey else {
                throw ParseErros.invalidInput
        }
        
        self.total = total
        self.incompleteResults = incompleteResults
        let items: [RepositoriesModel]? = itemsInfo.flatMap {
            return try? RepositoriesModel(info: $0)
        }
        self.items = items
    }
    
}
