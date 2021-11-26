//
//  CodableHandlerTest.swift
//  RepoListTests
//
//  Created by Yahia El-Dow on 26/11/2021.
//

import XCTest
@testable import RepoList

class CodableHandlerTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // should be return nil data when sent wrong data
        XCTAssertNil(CodableHandler.shared.decode(RepoArrayList.self, classJsonData: Data()))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
