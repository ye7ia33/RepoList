//
//  RepoListPresenterProtocol.swift
//  RepoList
//
//  Created by Yahia El-Dow on 26/11/2021.
//

import UIKit

/**
    use  **RepoListPresenterProtocol**  to impleement presenter methods actions .
*/
protocol RepoListPresenterProtocol: AnyObject {
    func reloadData()
    func didOpenDetailsScreen(repoModel: Repository)
}

/**
    use  **RepoListViewProtocol**  to impleement View methods actions and variable .
*/
protocol RepoListViewProtocol: NSObject {
    func viewDidLoad()
    var repoList: RepoArrayList? { get }
    func tableViewDidSelectItem(indexPath: IndexPath)
    func didStartSearchWith(str: String)
    func didEndSearch()
}
