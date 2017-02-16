//
//  Parser.swift
//  AppGitHub
//
//  Created by Fabio Miciano on 15/02/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation

public enum ParseErros: Error {
    case invalidInput
}

protocol Parser {
    
    func parseMainRequest(response: [String: Any]?) -> MainRequestModel?
    
    func parsePullRequest(response: [[String: Any]]?) -> [PullModel]?
}

extension Parser {
    
    func parseMainRequest(response: [String: Any]?) -> MainRequestModel? {
        
        guard let response = response else { return nil }
        
        return try? MainRequestModel(info: response)
    }
    
    func parsePullRequest(response: [[String: Any]]?) -> [PullModel]? {
        
        guard let response = response else { return nil }
        
        let model: [PullModel]? = try? response.flatMap(PullModel.init)
        print("MODEL PULL --- \(model)")
        return model
    }
}
