//
//  ResponseUtils.swift
//  TesteForSys
//
//  Created by Fabio Miciano on 14/02/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation

enum MainResponse {
    
    case success(model: MainRequestModel)
    case serverError(description: ServerError)
    case timeOut(description: ServerError)
    case noConnection(description: ServerError)
    case invalidResponse
}
