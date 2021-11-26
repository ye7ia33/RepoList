//
//  Repository.swift
//  RepoList
//
//  Created by Yahia El-Dow on 26/11/2021.
//

import Foundation
typealias RepoArrayList = [Repository]

struct Repository: Codable {
    let id: Int?
    let  name, fullName: String?
    let isPrivate: Bool?
    let owner: Owner?
    let htmlURL: String?
    let repoDescription: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case isPrivate = "private"
        case owner
        case htmlURL = "html_url"
        case repoDescription = "description"
    }
}

// MARK: - Owner
struct Owner: Codable {
    let id: Int?
    let avatarURL: String?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case  id
        case avatarURL = "avatar_url"
        case type
    }
}
