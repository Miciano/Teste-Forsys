//
//  RequestService.swift
//  AppGitHub
//
//  Created by Fabio Miciano on 15/02/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation
import Alamofire

class RequestService: Parser {
    
    lazy var alamofireManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        return SessionManager(configuration: configuration)
    }()
    
    
    func loadRepositories(page: Int, completion:@escaping (_ response: MainResponse)->Void) {
        
        alamofireManager.request("\(APIURLs.Main)page=\(page)", method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON
            { [weak self] (response) in
                
                switch response.result {
                case .success(let value):
                    let resultValue = value as? [String: Any]
                    switch response.response?.statusCode ?? 0 {
                    case 500:
                        let error = ServerError(statusCode: 500, description: "Erro 500 Bad Access")
                        completion(.serverError(description: error))
                    case 400...405:
                        let error = ServerError(statusCode: response.response?.statusCode ?? 0, description: "Erro de categoria 400")
                        completion(.serverError(description: error))
                    case 200:
                        let model = self?.parseMainRequest(response: resultValue)
                        completion(.success(model: model))
                    default:
                        completion(.invalidResponse)
                    }
                case .failure(let error):
                    switch error._code {
                    case -1009:
                        let error = ServerError(statusCode: -1009, description: "Sem conexão com a internet no momento")
                        completion(.noConnection(description: error))
                    case -1001:
                        let error = ServerError(statusCode: -1001, description: "TimeOut, atualize a tela")
                        completion(.timeOut(description: error))
                    default:
                        completion(.invalidResponse)
                    }
                }
        }
        
    }
}
