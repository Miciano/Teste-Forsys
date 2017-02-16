//
//  ResponseService.swift
//  AppGitHub
//
//  Created by Fabio Miciano on 15/02/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation
import UIKit

enum MainResponse {
    case success(model: MainRequestModel?)
    case serverError(description: ServerError)
    case timeOut(description: ServerError)
    case noConnection(description: ServerError)
    case invalidResponse
}

enum PullResponse {
    case success(model: [PullModel]?)
    case serverError(description: ServerError)
    case timeOut(description: ServerError)
    case noConnection(description: ServerError)
    case invalidResponse
}

enum ImageResponse {
    case success(model: UIImage?)
    case missingURL(description: ServerError)
    case serverErro(description: ServerError)
    case downloadCanceled(description: ServerError)
    case noConnection(description: ServerError)
    case timeOut(description: ServerError)
    case invalidResponse
}
