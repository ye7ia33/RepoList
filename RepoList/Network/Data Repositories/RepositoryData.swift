//
//  Repostory.swift
//  RepoList
//
//  Created by Yahia El-Dow on 26/11/2021.
//

import Foundation
typealias RepoArrayList = [Repository]

struct RepositoryData {
    
    func getRemoteData() {
        
    }
    
    func getLocalData(jsonFileName name: String) -> RepoArrayList? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return CodableHandler.shared.decode(RepoArrayList.self, classJsonData: jsonData) as? RepoArrayList
            }
        } catch {
            dLog(error)
        }
        return nil
    }
}
