//
//  RepoListViewProtocol.swift
//  RepoList
//
//  Created by Yahia El-Dow on 26/11/2021.
//

import UIKit

protocol RepoListViewProtocol: NSObject {
    func viewDidLoad()
    var numOfRepo: Int? { get }
    var repoList: RepoArrayList? { get }
}
