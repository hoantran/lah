//
//  LendAHandTests.swift
//  LendAHandTests
//
//  Created by Hoan Tran on 10/19/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import XCTest
@testable import LendAHand

// Had error: "Missing required module 'Firebase'"
// https://github.com/firebase/firebase-ios-sdk/issues/16
// "Add "${PODS_ROOT}/Firebase/Core/Sources" to your Tests target only under Build Settings -> Header Search Paths"


class LendAHandTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
