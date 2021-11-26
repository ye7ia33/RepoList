//
//  RepositoryType.swift
//  RepoList
//
//  Created by Yahia El-Dow on 26/11/2021.
//

import Foundation
import UIKit

enum RepositoryType: CaseIterable {
    case user
    case organization
    case unknown
    var labelColor: UIColor {
        switch self {
        case .user: return UIColor(red: 250/255, green: 176/255, blue: 0/255, alpha: 1)
        case .organization: return UIColor(red: 222/255, green: 52/255, blue: 11/255, alpha: 1)
        case .unknown: return .black
        }
    }
    
    var title: String {
        switch self {
        case .user: return "User"
        case .organization: return "Organization"
        case .unknown: return ""
        }
    }
    
    static func getCase(string:String?) -> RepositoryType {
        return self.allCases.first{"\($0.title)" == string} ?? .unknown
    }

}
