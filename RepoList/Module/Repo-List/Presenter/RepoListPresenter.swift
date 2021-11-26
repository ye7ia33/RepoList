//
//  RepoListPresenter.swift
//  RepoList
//
//  Created by Yahia El-Dow on 26/11/2021.
//

import UIKit

class RepoListPresenter: NSObject, RepoListViewProtocol {
    private  var delegate: RepoListPresenterProtocol?
    internal var numOfRepo: Int?
    internal var repoList: RepoArrayList?
    
    init(delegate: RepoListPresenterProtocol) {
        self.delegate = delegate
    }
    
    func viewDidLoad() {
        self.getData()
    }
    
    private func getData() {
        self.repoList = RepositoryData().getLocalData(jsonFileName: "MocData")
        self.numOfRepo = self.repoList?.count ?? 0
        self.delegate?.reloadData()
    }

}
