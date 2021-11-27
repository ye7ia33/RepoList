//
//  RepoListPresenter.swift
//  RepoList
//
//  Created by Yahia El-Dow on 26/11/2021.
//

import UIKit

final class RepoListPresenter: NSObject, RepoListViewProtocol {
    private  weak var delegate: RepoListPresenterProtocol?
    internal var displayedList: RepoArrayList?
    private var mainList: RepoArrayList?
    private var filteredArray: RepoArrayList?
    private var isFiltering: Bool = false
    
    /** important init RepoListPresenter with RepoListPresenterProtocol  */
    init(delegate: RepoListPresenterProtocol) {
        self.delegate = delegate
        self.displayedList = RepoArrayList()
    }
    
    //MARK: call tableViewDidSelectItem method after user touch on cell to open details screen.
    func tableViewDidSelectItem(indexPath: IndexPath) {
        guard let repo = self.displayedList?[safe: indexPath.row] else { return }
        self.delegate?.didOpenDetailsScreen(repoModel: repo)
    }
    /**
     send search key string to filter data
     */
    internal func didStartSearchWith(str: String) {
        if str.count < 2 {
            self.didEndSearch()
            return
        }
        self.isFiltering = true
        if self.filteredArray == nil { self.filteredArray = displayedList }
        self.displayedList = filteredArray?.filter({
            return $0.fullName?.lowercased().contains(str.lowercased()) ?? false
        })
        isFiltering ? self.delegate?.reloadData() : self.didEndSearch()
    }
    
    /**
     didEndSearch Method calling if user end search or search key string length smaller than 2
     
     re-init repoList data
     
     set isFiltering = false
     
     Release filteredArray
     */
    internal func didEndSearch() {
        if self.filteredArray != nil {
            self.displayedList = self.filteredArray
        }
        self.isFiltering = false
        self.filteredArray = nil
        self.delegate?.reloadData()
    }
    
    func loadMore() {
        self.appendData()
    }
    
    private func appendData() {
        if self.mainList?.count == 0 { return }
        let listSize = self.mainList?.count ?? 0
        for idx in 0...listSize {
            if idx >= 10 && (self.displayedList?.count ?? 0) > 20 { break }
            if let repoModel = self.mainList?[safe: idx] {
                self.displayedList?.append(repoModel)
                self.mainList?.remove(at: idx)
            } else { break }
        }
        self.delegate?.reloadData()
    }
}

extension RepoListPresenter: RequestDelegate {
    /** *GET Remote Data* */
    internal func getRemoteData() {
        let request = ServerRequest()
        request.requestDelegate = self
        request.execute("https://api.github.com/repositories", httpMethod: "GET")
    }
    
    //MARK: we are using local data because github api has limitaion to calling API Multi times.
    internal func getLocalData() {
        self.getLocalData(jsonFileName: "MocData")
    }
    
    internal func didFinshRequest(_ data: Data!) {
        guard let _repoList = CodableHandler.shared.decode(RepoArrayList.self, classJsonData: data) as? RepoArrayList else {
            return
        }
        self.mainList = _repoList
        self.appendData()
    }
    
    internal func didFinshRequestWithError(_ error: Error!) {
        self.delegate?.didGetErrorFromServerWithErrorMsg(error.localizedDescription)
    }
    
    /** *GET  Local Data* */
    private func getLocalData(jsonFileName name: String) {
        if let jsonData = ReadLocalData.shared.get(fileName: name),
           let _repoList = CodableHandler.shared.decode(RepoArrayList.self, classJsonData: jsonData) as? RepoArrayList {
            self.mainList = _repoList
            self.appendData()
        }
    }
    
}
