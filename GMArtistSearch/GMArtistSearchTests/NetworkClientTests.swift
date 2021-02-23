//
//  NetworkManagerTests.swift
//  GMArtistSearchTests
//
//  Created by Augustus Wilson on 02/18/21.
//  Copyright © 2021 Augustus Wilson. All rights reserved.
//

import XCTest
@testable import GMArtistSearch

class NetworkManagerTests: XCTestCase {
    
    var session : MockURLSession?
    
    let mockJson =   """
    [
        {
            "artistName": "Lil Durk",
            "id": "1519881180",
            "releaseDate": "2020-06-26",
            "name": "Just Cause Y'all Waited 2 (Deluxe)",
            "kind": "album",
            "copyright": "℗ 2020 Alamo (Geffen Records)",
            "artistId": "541282483",
            "contentAdvisoryRating": "Explicit",
            "artistUrl": "https://music.apple.com/us/artist/lil-durk/541282483?app=music",
            "artworkUrl100": "https://is2-ssl.mzstatic.com/image/thumb/Music123/v4/bf/cc/4f/bfcc4f53-db3b-95e8-13a3-e1d40010a4a9/20UMGIM49384.rgb.jpg/200x200bb.png",
            "genres": [
                {
                    "genreId": "18",
                    "name": "Hip-Hop/Rap",
                    "url": "https://itunes.apple.com/us/genre/id18"
                },
                {
                    "genreId": "34",
                    "name": "Music",
                    "url": "https://itunes.apple.com/us/genre/id34"
                }
            ],
            "url": "https://music.apple.com/us/album/just-cause-yall-waited-2-deluxe/1519881180?app=music"
        }
    ]
    """
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInvalidUrlIsReturnedWhenUrlIsNotCorrect() throws {
        let expect = expectation(description: "Completion called succesfully")
        let error = NSError(domain: "Test", code: 101, userInfo: nil)
        session = MockURLSession(data: nil, urlResponse: nil , error: error)
        
        if let session = session {
            let networkClient = URLSessionNetworkClient(urlSession: session)
            var returnedError : CustomError? = nil
            networkClient.get(url: "") { result in
                guard case .failure(let error) = result else {
                    expect.fulfill();
                    return }
                returnedError = error
                expect.fulfill();
            }
            
            wait(for: [expect], timeout: 1)
            XCTAssertNotNil(returnedError)
            XCTAssertEqual(returnedError, CustomError.invalidUrl)
        }
    }

    
    func testDataisReturnedProperlyWhenServerRespondsWithData() throws {
        let expect = expectation(description: "Completion called succesfully")
        let data = Data(mockJson.utf8)
        let response = HTTPURLResponse(url: URL(string: "https://www.example.com")!, statusCode: 200, httpVersion: "1/1 ", headerFields: ["test":"test"])
        session = MockURLSession(data: data, urlResponse: response , error: nil)
        
        if let session = session {
            let networkClient = URLSessionNetworkClient(urlSession: session)
            var returnData : Data? = nil
            networkClient.get(url: "https://www.example.com") { result in
                guard case .success(let data) = result else {
                    expect.fulfill();
                    return }
                returnData = data
                expect.fulfill();
            }
            
            wait(for: [expect], timeout: 1)
            XCTAssertNotNil(returnData)
            XCTAssertEqual(data, returnData)
        }
    }
    
    func testNoDataErrorIsReturnedWhenServerRespondsWithNoData() throws {
        let expect = expectation(description: "Completion called succesfully")
        let response = HTTPURLResponse(url: URL(string: "https://www.example.com")!, statusCode: 200, httpVersion: "1/1 ", headerFields: ["test":"test"])
        session = MockURLSession(data: nil, urlResponse: response , error: nil)
        
        if let session = session {
            let networkClient = URLSessionNetworkClient(urlSession: session)
            var returnedError : CustomError? = nil
            networkClient.get(url: "https://www.example.com") { result in
                guard case .failure(let error) = result else {
                    expect.fulfill();
                    return }
                returnedError = error
                expect.fulfill();
            }
            
            wait(for: [expect], timeout: 1)
            XCTAssertNotNil(returnedError)
            XCTAssertEqual(returnedError, CustomError.noData)
        }
    }
    
    func testServerDownIsReturnedWhenServerRespondsWith503() throws {
        let expect = expectation(description: "Completion called succesfully")
        let response = HTTPURLResponse(url: URL(string: "https://www.example.com")!, statusCode: 503, httpVersion: "1/1 ", headerFields: ["test":"test"])
        session = MockURLSession(data: nil, urlResponse: response , error: nil)
        
        if let session = session {
            let networkClient = URLSessionNetworkClient(urlSession: session)
            var returnedError : CustomError? = nil
            networkClient.get(url: "https://www.example.com") { result in
                guard case .failure(let error) = result else {
                    expect.fulfill();
                    return }
                returnedError = error
                expect.fulfill();
            }
            
            wait(for: [expect], timeout: 1)
            XCTAssertNotNil(returnedError)
            XCTAssertEqual(returnedError, CustomError.serverDown)
        }
    }
    
    func testBadRequestIsReturnedWhenServerRespondsWith400() throws {
        let expect = expectation(description: "Completion called succesfully")
        let response = HTTPURLResponse(url: URL(string: "https://www.example.com")!, statusCode: 400, httpVersion: "1/1 ", headerFields: ["test":"test"])
        session = MockURLSession(data: nil, urlResponse: response , error: nil)
        
        if let session = session {
            let networkClient = URLSessionNetworkClient(urlSession: session)
            var returnedError : CustomError? = nil
            networkClient.get(url: "https://www.example.com") { result in
                guard case .failure(let error) = result else {
                    expect.fulfill();
                    return }
                returnedError = error
                expect.fulfill();
            }
            
            wait(for: [expect], timeout: 1)
            XCTAssertNotNil(returnedError)
            XCTAssertEqual(returnedError, CustomError.badRequest)
        }
    }
    
    func testUnknownErrorIsReturnedWhenServerRespondsWith509() throws {
        let expect = expectation(description: "Completion called succesfully")
        let response = HTTPURLResponse(url: URL(string: "https://www.example.com")!, statusCode: 509, httpVersion: "1/1", headerFields: ["test":"test"])
        session = MockURLSession(data: nil, urlResponse: response , error: nil)
        
        if let session = session {
            let networkClient = URLSessionNetworkClient(urlSession: session)
            var returnedError : CustomError? = nil
            networkClient.get(url: "https://www.example.com") { result in
                guard case .failure(let error) = result else {
                    expect.fulfill();
                    return }
                returnedError = error
                expect.fulfill();
            }
            
            wait(for: [expect], timeout: 1)
            XCTAssertNotNil(returnedError)
            XCTAssertEqual(returnedError, CustomError.unknown)
        }
    }

    
    func testServerErrorIsReturnedWhenServerReturnsError() throws {
        let expect = expectation(description: "Completion called succesfully")
        let error = NSError(domain: "Test", code: 101, userInfo: nil)
        session = MockURLSession(data: nil, urlResponse: nil , error: error)
        
        if let session = session {
            let networkClient = URLSessionNetworkClient(urlSession: session)
            var returnedError : CustomError? = nil
            networkClient.get(url: "https://www.example.com") { result in
                guard case .failure(let error) = result else {
                    expect.fulfill();
                    return }
                returnedError = error
                expect.fulfill();
            }
            
            wait(for: [expect], timeout: 1)
            XCTAssertNotNil(returnedError)
            XCTAssertEqual(returnedError, CustomError.serverError)
        }
    }

    
}


class MockURLSession: URLSession {
    private let mockTask: MockTask
    
    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        mockTask = MockTask(data: data, urlResponse: urlResponse, error:
            error)
    }
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        print("Inside MockurlSession")
        mockTask.completionHandler = completionHandler
        return mockTask
    }
}


class MockTask: URLSessionDataTask {
    private let data: Data?
    private let urlResponse: URLResponse?
    
    private let _error: Error?
    override var error: Error? {
        return _error
    }
    
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)!
    
    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        print("Inside MockTask")
        self.data = data
        self.urlResponse = urlResponse
        self._error = error
    }
    
    override func resume() {
        print("Inside MockTask Resume")
        DispatchQueue.main.async {
            self.completionHandler(self.data, self.urlResponse, self.error)
        }
    }
}
