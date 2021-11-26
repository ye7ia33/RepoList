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
        case .user: return .green
        case .organization: return .cyan
        case .unknown: return .black
        }
    }
    
    var title: String {
        switch self {
        case .user: return "User"
        case .organization: return "Osrganization"
        case .unknown: return ""
        }
    }
    
    static func getCase(string:String?) -> RepositoryType {
        return self.allCases.first{"\($0.title)" == string} ?? .unknown
    }

}
