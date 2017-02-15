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
    
    var totalCountKey: Int? {
        return self["total_count"] as? Int
    }
    
    var incompleteResultsKey: Bool? {
        return self["incomplete_results"] as? Bool
    }
    
    var itemsKey: [[String: Any]]? {
        return self["items"] as? [[String: Any]]
    }
    
    var loginKey: String? {
        return self["login"] as? String
    }
    
    var avatarUrlKey: String? {
        return self["avatar_url"] as? String
    }
}
