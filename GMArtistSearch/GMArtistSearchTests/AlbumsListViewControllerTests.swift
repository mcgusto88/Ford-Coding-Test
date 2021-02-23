//
//  GMArtistSearchTests.swift
//  GMArtistSearchTests
//
//  Created by Augustus Wilson on 2/18/21.
//  Copyright © 2021 Augustus Wilson. All rights reserved.
//

import XCTest
@testable import GMArtistSearch

class GMArtistSearchTests: XCTestCase {
    
    var viewController : AlbumsListViewController?
    
    override func setUpWithError() throws {
        let mockNetworkClient = MockHTTPClient()
        let mockLoader = MockAlbumsLoader(networkClient: mockNetworkClient,jsonDecoder: JSONDecoder())
        viewController = AlbumsListViewController(dataLoader: mockLoader, selectionHandler: {_ in
        })
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoaderGetAlbumsIsCalledOnce() throws {
        let mockNetworkClient = MockHTTPClient()
        let mockLoader = MockAlbumsLoader(networkClient: mockNetworkClient,jsonDecoder: JSONDecoder())
        viewController = AlbumsListViewController(dataLoader: mockLoader, selectionHandler: {_ in
        })
        viewController?.getAlbums(artistName: "micheal")
        XCTAssert(mockLoader.loadedCalled)
    }
    
    func testTableViewHas100AlbumsWhenViewControllerIsLoaded() throws {
        let _ = viewController?.view
        XCTAssert(viewController?.tableView.numberOfRows(inSection: 0) == 1)
    }
    
}


class MockHTTPClient : HTTPClient {
    
    func get(url: String, completion: @escaping ((Result<Data, CustomError>) -> Void)) {
        if let data = NSData(contentsOfFile: url) {
            completion(.success(data as Data))
        }
    }
}

class MockAlbumsLoader : AlbumsDataLoader {
    var networkClient: HTTPClient
    var jsonDecoder: JSONDecoder
    var loadedCalled = false

    init(networkClient:HTTPClient,jsonDecoder:JSONDecoder) {
        self.networkClient = networkClient
        self.jsonDecoder = jsonDecoder
    }
    
        func getAlbums(searchTerm: String, completion: ((Result<[Album], CustomError>) -> Void)?) {
        loadedCalled = true
        let album = Album(name: "Man In the Mirror", artistName: "Michael Jackson", imageUrl: "https://is2-ssl.mzstatic.com/image/thumb/Music127/v4/8a/65/be/8a65bef2-f23d-e43d-9124-f5e4293513f7/source/100x100bb.jpg", releaseDate: "1987-08-31", primaryGenreName: "Pop", trackPrice: 1.29)
        completion?(.success([album]))
    }
}

