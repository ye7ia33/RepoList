//
//  ReadLocalDataTest.swift
//  RepoListTests
//
//  Created by Yahia El-Dow on 26/11/2021.
//

import XCTest
@testable import RepoList

class ReadLocalDataTest: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // Should be return data from Json File
        XCTAssertNotNil(ReadLocalData.shared.get(fileName: "MocData"))
        
        // should be return nil data if writen wrong file name
        XCTAssertNil(ReadLocalData.shared.get(fileName: "wrongFileName"))

    }

    func testCheckTypeOfData() throws {
        let jsonData = ReadLocalData.shared.get(fileName: "MocData") ?? Data()
        let repoList = CodableHandler.shared.decode(RepoArrayList.self, classJsonData: jsonData ) as? RepoArrayList
        XCTAssertTrue((repoList != nil), "Data is not applied model")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
