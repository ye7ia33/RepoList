//
//  DetailsPresenterProtocol.swift
//  RepoList
//
//  Created by Yahia El-Dow on 26/11/2021.
//

import UIKit

protocol DetailsPresenterProtocol: NSObject {
    func reloadData()
    func hiddenOpenRepoButton()
}

protocol DetailsViewProtocol: NSObject {
    func viewDidLoad()
    var avatarUrl: String? { get }
    var ownerName: String? { get }
    var repoName: String? { get }
    var repoType: RepositoryType? { get }
    var repoDescription: String? { get }
    var repoStatus: String? { get }
    var repoURL: String? { get }
}
