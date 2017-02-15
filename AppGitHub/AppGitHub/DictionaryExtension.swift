//
//  DictionaryExtension.swift
//  AppGitHub
//
//  Created by Fabio Miciano on 15/02/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation
import UIKit

extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {
    
    //PRAGMA MARK: -- MAIN REQUEST MODEL --
    var totalCountKey: Int? {
        return self["total_count"] as? Int
    }
    
    var incompleteResultsKey: Bool? {
        return self["incomplete_results"] as? Bool
    }
    
    //PRAGMA MARK: -- REPOSITORIES MODEL --
    var idKey: Int? {
        return self["id"] as? Int
    }
    
    var nameKey: String? {
        return self["name"] as? String
    }
    
    var ownerKey: [String: Any]? {
        return self["owner"] as? [String: Any]
    }
    
    var pullsUrlsKey: String? {
        return self["pulls_url"] as? String
    }
    
    var startsCountKey: Int? {
        return self["stargazers_count"] as? Int
    }
    
    var forksCountKey: Int? {
        return self["forks_count"] as? Int
    }
    
    var descriptionKey: String? {
        return self["description"] as? String
    }
    
    var itemsKey: [[String: Any]]? {
        return self["items"] as? [[String: Any]]
    }
    
    //PRAGMA MARK: -- OWNER MODEL --
    var loginKey: String? {
        return self["login"] as? String
    }
    
    var avatarUrlKey: String? {
        return self["avatar_url"] as? String
    }
}
