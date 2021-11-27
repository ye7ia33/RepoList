//
//  DetailsPresenter.swift
//  RepoList
//
//  Created by Yahia El-Dow on 26/11/2021.
//

import UIKit

final class DetailsPresenter: NSObject {
    private weak var delegate: DetailsPresenterProtocol?
    private var repoModel: Repository?
    
    init(delegate: DetailsPresenterProtocol, repoModel: Repository) {
        self.delegate = delegate
        self.repoModel = repoModel
    }
    
    internal  func viewDidLoad() {
        self.delegate?.reloadData()
    }
    
}

extension DetailsPresenter: DetailsViewProtocol {
    internal var avatarUrl: String? {
        return self.repoModel?.owner?.avatarURL
    }
    
    internal var ownerName: String? {
        return self.repoModel?.fullName
    }
    
    internal var repoName: String? {
        return self.repoModel?.name
    }
    
    internal var repoType: RepositoryType? {
        return RepositoryType.getCase(string: self.repoModel?.owner?.type)
    }
    
    internal var repoDescription: String? {
        return self.repoModel?.repoDescription
    }
    
    internal var repoStatus: String? {
        return (self.repoModel?.isPrivate ?? false) ? "Public" : "Private"
    }
    
    internal var repoURL: String? {
        guard let url = self.repoModel?.htmlURL, !url.isEmpty  else {
            self.delegate?.hiddenOpenRepoButton()
            return nil
        }
        return self.repoModel?.htmlURL
    }
}
