//
//  ResponseService.swift
//  AppGitHub
//
//  Created by Fabio Miciano on 15/02/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation
import UIKit

//Tipos de sucesso e erro usadas no request de Repositorio
enum MainResponse {
    case success(model: MainRequestModel?)
    case serverError(description: ServerError)
    case timeOut(description: ServerError)
    case noConnection(description: ServerError)
    case invalidResponse
}

//Tipos de sucesso e erro usadas no request de PullRequests
enum PullResponse {
    case success(model: [PullModel]?)
    case serverError(description: ServerError)
    case timeOut(description: ServerError)
    case noConnection(description: ServerError)
    case invalidResponse
}

//Tipos de sucesso e erro usadas no request de Imagem
enum ImageResponse {
    case success(model: UIImage?)
    case missingURL(description: ServerError)
    case serverErro(description: ServerError)
    case downloadCanceled(description: ServerError)
    case noConnection(description: ServerError)
    case timeOut(description: ServerError)
    case invalidResponse
}
