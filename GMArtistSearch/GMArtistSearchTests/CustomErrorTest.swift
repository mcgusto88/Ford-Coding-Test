//
//  CustomErrorTest.swift
//  GMArtistSearchTests
//
//  Created by Augustus Wilson on 2/18/21.
//  Copyright © 2021 Augustus Wilson. All rights reserved.
//

import XCTest

class CustomErrorTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInvalidUrlHasCorrectErrorDescription() throws {
        let error = CustomError.invalidUrl
        assert(error.localizedDescription=="Error Occured (Code 1)")
    }
    
    func testNoConnectionHasCorrectErrorDescription() throws {
        let error = CustomError.noConnection
        assert(error.localizedDescription=="No Internet Connection")
    }

    func testBadDataHasCorrectErrorDescription() throws {
        let error = CustomError.badRequest
        assert(error.localizedDescription=="Error Occured (Code 3)")
    }
    
    func testNoDataHasCorrectErrorDescription() throws {
        let error = CustomError.noData
        assert(error.localizedDescription=="Error Occured (Code 4)")
    }
    
    func testUnknownHasCorrectErrorDescription() throws {
        let error = CustomError.unknown
        assert(error.localizedDescription=="Error Occured (Code 5)")
    }

    func testServerDownHasCorrectErrorDescription() throws {
        let error = CustomError.serverDown
        assert(error.localizedDescription=="Error Occured (Code 6)")
    }

    func testDecodeErrorHasCorrectErrorDescription() throws {
        let error = CustomError.decodeError
        assert(error.localizedDescription=="Error Occured (Code 7)")
    }

    func testServerErrorHasCorrectErrorDescription() throws {
        let error = CustomError.serverError
        assert(error.localizedDescription=="Error Occured (Code 8)")
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
