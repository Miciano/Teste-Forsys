//
//  Parser.swift
//  AppGitHub
//
//  Created by Fabio Miciano on 15/02/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation

//Enum responsavel por armazenar tipos de erro no parse das informações
public enum ParseErros: Error {
    case invalidInput
}

//Protocolo Parser contem todas as funções de parse dos JSONs que retornam nos requests
protocol Parser {
    func parseMainRequest(response: [String: Any]?) -> MainRequestModel?
    func parsePullRequest(response: [[String: Any]]?) -> [PullModel]?
}

//Extension implementa as funções mantendo códigos encapsulados não obrigando cada classe que usar o protocolo ter que fazer uma implementação diferente
extension Parser {
    
    func parseMainRequest(response: [String: Any]?) -> MainRequestModel? {
        
        //Faço unwrap do response
        guard let response = response else { return nil }
        //Crio o model
        return try? MainRequestModel(info: response)
    }
    
    func parsePullRequest(response: [[String: Any]]?) -> [PullModel]? {
        
        //Faço unwrap do response
        guard let response = response else { return nil }
        
        //Crio o model
        let model: [PullModel]? = try? response.flatMap(PullModel.init)
        return model
    }
}
