//
//  DetailsPresenter.swift
//  RepoList
//
//  Created by Yahia El-Dow on 26/11/2021.
//

import UIKit

class DetailsPresenter: NSObject {
    private weak var delegate: DetailsPresenterProtocol?
    private var repoModel: Repository?
    
    init(delegate: DetailsPresenterProtocol, repoModel: Repository) {
        self.delegate = delegate
        self.repoModel = repoModel
       
    }
    
    func viewDidLoad() {
        self.delegate?.reloadData()
    }
    
}

extension DetailsPresenter: DetailsViewProtocol {
    var avatarUrl: String? {
        return self.repoModel?.owner?.avatarURL
    }
    
    var ownerName: String? {
        return self.repoModel?.fullName
    }
    
    var repoName: String? {
        return self.repoModel?.name
    }
    
    var repoType: RepositoryType? {
        return RepositoryType.getCase(string: self.repoModel?.owner?.type)
    }
    
    var repoDescription: String? {
        return self.repoModel?.repoDescription
    }
    
    var repoStatus: String? {
        return (self.repoModel?.isPrivate ?? false) ? "Public" : "Private"
    }
    
    var repoURL: String? {
        guard let url = self.repoModel?.htmlURL, !url.isEmpty  else {
            self.delegate?.hiddenOpenRepoButton()
            return nil
        }
        return self.repoModel?.htmlURL
    }
}
