//
//  RepoListPresenter.swift
//  RepoList
//
//  Created by Yahia El-Dow on 26/11/2021.
//

import UIKit

class RepoListPresenter: NSObject, RepoListViewProtocol {
    private  weak var delegate: RepoListPresenterProtocol?
    internal var repoList: RepoArrayList?
    private var mainList: RepoArrayList?
    private var isFiltering: Bool = false
    
    init(delegate: RepoListPresenterProtocol) {
        self.delegate = delegate
    }
    
    func viewDidLoad() {
        self.getData()
    }
    
    private func getData() {
        self.repoList = RepositoryData().getLocalData(jsonFileName: "MocData")
        self.delegate?.reloadData()
    }
    
    func tableViewDidSelectItem(indexPath: IndexPath) {
        guard let repo = self.repoList?[safe: indexPath.row] else { return }
        self.delegate?.didOpenDetailsScreen(repoModel: repo)
    }
    
    func didStartSearchWith(str: String) {
        if str.count < 2 {
            self.didEndSearch()
            return
        }
        self.isFiltering = true
        if self.mainList == nil { self.mainList = repoList }
        self.repoList = mainList?.filter({
            return $0.fullName?.lowercased().contains(str.lowercased()) ?? false
        })
        isFiltering ? self.delegate?.reloadData() : self.didEndSearch()
    }
    
    func didEndSearch() {
        if self.mainList != nil {
            self.repoList = self.mainList
        }
        self.isFiltering = false
        self.mainList = nil
        self.delegate?.reloadData()
    }
}
