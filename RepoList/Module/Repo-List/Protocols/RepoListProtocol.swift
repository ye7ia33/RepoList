//
//  RepoListPresenterProtocol.swift
//  RepoList
//
//  Created by Yahia El-Dow on 26/11/2021.
//

import UIKit

protocol RepoListPresenterProtocol: AnyObject {
    func reloadData()
    func didOpenDetailsScreen(repoModel: Repository)
}


protocol RepoListViewProtocol: NSObject {
    func viewDidLoad()
    var repoList: RepoArrayList? { get }
    func tableViewDidSelectItem(indexPath: IndexPath)
    func didStartSearchWith(str: String)
    func didEndSearch()
}
