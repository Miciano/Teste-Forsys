//
//  MainRequestModel.swift
//  TesteForSys
//
//  Created by Fabio Miciano on 14/02/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation

struct MainRequestModel {
    let total: Int
    let incompleteResults: Bool
    let items: [RepositoriesModel]
}
