//
//  GMArtistSearchUITests.swift
//  GMArtistSearchUITests
//
//  Created by Augustus Wilson on 2/18/21.
//  Copyright © 2021 Augustus Wilson. All rights reserved.
//

import XCTest

class GMArtistSearchUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        app.launchArguments = ["UITests"]
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test000AlbumListExists() throws {
        app.launch()
        let tableView = app.tables["Albums List"]
        assert(tableView.exists)
    }
    
    func test001LoadingIndicatorShowsOnLoad() throws {
        app.launch()
        let loadingIndicator = app.activityIndicators["Album Loading Indicator"]
        assert(loadingIndicator.exists)
    }
    
    func test002LoadingIndicatoraHidesAfterLoad() throws {
        app.launch()
        let loadingIndicator = app.activityIndicators["Album Loading Indicator"]
        
        let tableView = app.tables["Albums List"]
        let tableViewCell = tableView.cells.element(boundBy: 0)
        
        assert(tableViewCell.waitForExistence(timeout: 3),"Albums Failed within 3 seconds")
        assert(!loadingIndicator.exists,"Loading indicator not hidden")
    }
    
    func test003AlbumListExistsAfterLoad() throws {
        app.launch()
        let tableView = app.tables["Albums List"]
        let tableViewCell = tableView.cells.element(boundBy: 0)
        assert(tableViewCell.waitForExistence(timeout: 3),"Albums Failed within 3 seconds")
                
        let albumName = tableViewCell.staticTexts["Album Name"]
        assert(albumName.exists, "Album Name is not displayed")
        assert(albumName.label == "Man In the Mirror")
        
        let artistName = tableViewCell.staticTexts["Artist Name"]
        assert(artistName.exists, "Artist Name is not displayed")
        assert(artistName.label == "Michael Jackson")
        
        let image = tableViewCell.images["Album Image"]
        assert(image.exists, "Album Image is not displayed")
        XCTAssertNotNil(image)
    }

    func test004AlbumListHasProperDetailsOnCell10() throws {
        app.launch()
        let tableView = app.tables["Albums List"]
        
        let tableViewCell = tableView.cells.element(boundBy: 9)
        assert(tableViewCell.waitForExistence(timeout: 3),"Albums Failed within 3 seconds")
                
        let albumName = tableViewCell.staticTexts["Album Name"]
        assert(albumName.exists, "Album Name is not displayed")
        assert(albumName.label == "I Want You Back")
        
        let artistName = tableViewCell.staticTexts["Artist Name"]
        assert(artistName.exists, "Artist Name is not displayed")
        assert(artistName.label == "Jackson 5")
        
        let image = tableViewCell.images["Album Image"]
        assert(image.exists, "Album Image is not displayed")
        XCTAssertNotNil(image)
    }

    
    func test005AlbumListHasProperDetailsAtTheEnd() throws {
        app.launch()
        let tableView = app.tables["Albums List"]
        
        let tableViewCell = tableView.cells.element(boundBy: 49)
        assert(tableViewCell.waitForExistence(timeout: 3),"Albums Failed within 3 seconds")
                
        let albumName = tableViewCell.staticTexts["Album Name"]
        assert(albumName.exists, "Album Name is not displayed")
        assert(albumName.label == "Micheal Jackson")
        
        let artistName = tableViewCell.staticTexts["Artist Name"]
        assert(artistName.exists, "Artist Name is not displayed")
        assert(artistName.label == "Adam")
        
        let image = tableViewCell.images["Album Image"]
        assert(image.exists, "Album Image is not displayed")
        XCTAssertNotNil(image)
    }

}
