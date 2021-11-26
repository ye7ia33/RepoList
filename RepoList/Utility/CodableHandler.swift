//  CodableHandler.swift
//
//  Created by Yahia El-Dow
//  Copyright © 2021 Yahia El-Dow. All rights reserved.
//

import UIKit

struct CodableHandler {
    static let shared = CodableHandler()
    
    private init() { }
    
    func decode<T : Decodable>(_  type: T.Type , classJsonData : Data) -> Any?{
        let decoder = JSONDecoder()
        let modelClass = try? decoder.decode(type.self, from: classJsonData)
        return modelClass ?? nil
    }
}
