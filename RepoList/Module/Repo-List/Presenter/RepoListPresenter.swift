//
//  RepoListPresenter.swift
//  RepoList
//
//  Created by Yahia El-Dow on 26/11/2021.
//

import UIKit

final class RepoListPresenter: NSObject, RepoListViewProtocol {
    private  weak var delegate: RepoListPresenterProtocol?
    internal var repoList: RepoArrayList?
    private var mainList: RepoArrayList?
    private var isFiltering: Bool = false
    
    /** important init RepoListPresenter with RepoListPresenterProtocol  */
    init(delegate: RepoListPresenterProtocol) {
        self.delegate = delegate
    }
    //MARK: call viewDidLoad method after view controller is fire ViewDidLoad Override method.
    func viewDidLoad() {
        /// Load remote Data.
//        self.getRemoteData()
        /// Reolad Data From json file
        self.getLocalData(jsonFileName: "MocData")
    }
    
    //MARK: call tableViewDidSelectItem method after user touch on cell to open details screen.
    func tableViewDidSelectItem(indexPath: IndexPath) {
        guard let repo = self.repoList?[safe: indexPath.row] else { return }
        self.delegate?.didOpenDetailsScreen(repoModel: repo)
    }
    /**
        send search key string to filter data
     */
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
    
    /**
     didEndSearch Method calling if user end search or search key string length smaller than 2
     
        re-init repoList data

        set isFiltering = false
     
        release MainList Data
     
     */
    func didEndSearch() {
        if self.mainList != nil {
            self.repoList = self.mainList
        }
        self.isFiltering = false
        self.mainList = nil
        self.delegate?.reloadData()
    }
}

extension RepoListPresenter: RequestDelegate {
    /** *GET Remote Data* */
    private func getRemoteData() {
        let request = ServerRequest()
        request.requestDelegate = self
        request.execute("https://api.github.com/repositories", httpMethod: "GET")
    }
   
    func didFinshRequest(_ data: Data!) {
        guard let _repoList = CodableHandler.shared.decode(RepoArrayList.self, classJsonData: data) as? RepoArrayList else {
            return
        }
        self.repoList = _repoList
        self.delegate?.reloadData()
    }
    
    func didFinshRequestWithError(_ errorCode: Error!) {
        dLog(errorCode)
    }
    /** *GET  Local Data* */
    private func getLocalData(jsonFileName name: String) {
        if let jsonData = ReadLocalData.shared.get(fileName: name),
           let _repoList = CodableHandler.shared.decode(RepoArrayList.self, classJsonData: jsonData) as? RepoArrayList {
            self.repoList = _repoList
            self.delegate?.reloadData()
        }
    }

}
