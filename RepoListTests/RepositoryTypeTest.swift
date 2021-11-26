//
//  RepositoryTypeTest.swift
//  RepoListTests
//
//  Created by Yahia El-Dow on 26/11/2021.
//

import XCTest
@testable import RepoList

class RepositoryTypeTest: XCTestCase {
    
    func testUserType() throws {
        self.textType(key: "User", correctType: .user)
        self.textType(key: "Organization", correctType: .organization)
        self.textType(key: "", correctType: .unknown)
    }

    func textType(key: String, correctType: RepositoryType) {
        let type = RepositoryType.getCase(string: key)
        XCTAssertTrue(type == correctType)
    }


}
