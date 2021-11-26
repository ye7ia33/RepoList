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
    
    init(delegate: RepoListPresenterProtocol) {
        self.delegate = delegate
    }
    
    func viewDidLoad() {
        self.getRemoteData()
//        self.getLocalData(jsonFileName: "MocData")
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

extension RepoListPresenter: RequestDelegate {
    private func getRemoteData() {
        let request = ServerRequest()
        request.requestDelegate = self
        request.execute("https://api.github.com/repositories", httpMethod: "GET")
    }
    
    private func getLocalData(jsonFileName name: String) {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8),
            let _repoList = CodableHandler.shared.decode(RepoArrayList.self, classJsonData: jsonData) as? RepoArrayList {
                self.repoList = _repoList
                self.delegate?.reloadData()
            }
        } catch {
            dLog(error)
        }
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
}
