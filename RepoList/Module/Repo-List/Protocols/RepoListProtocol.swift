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
    func didGetErrorFromServerWithErrorMsg(_ msg: String)
}

/**
    use  **RepoListViewProtocol**  to impleement View methods actions and variable .
*/
protocol RepoListViewProtocol: NSObject {
    func getLocalData()
    func getRemoteData()
    var displayedList: RepoArrayList? { get }
    func tableViewDidSelectItem(indexPath: IndexPath)
    func didStartSearchWith(str: String)
    func didEndSearch()
    func loadMore()
}
