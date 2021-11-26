//
//  ReadLocalData.swift
//  RepoList
//
//  Created by Yahia El-Dow on 26/11/2021.
//

import Foundation

struct ReadLocalData {
    static let shared = ReadLocalData()
    
    private init() { }
    
    func get(fileName name: String, fileExtension: String = "json") -> Data? {
       do {
           if let bundlePath = Bundle.main.path(forResource: name, ofType: fileExtension),
              let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
               return jsonData
           }
       } catch {
           dLog(error)
       }
        return nil
   }
}
