//
//  AlbumsDataLoaderTests.swift
//  GMArtistSearchTests
//
//  Created by Augustus Wilson on 2/18/21.
//  Copyright © 2021 Augustus Wilson. All rights reserved.
//

import XCTest

class AlbumsDataLoaderTests: XCTestCase {
        
    let mockFeed =   """
    {
        "resultCount": 50,
        "results": [
            {
                "wrapperType": "track",
                "kind": "song",
                "artistId": 32940,
                "collectionId": 159292399,
                "trackId": 159294478,
                "artistName": "Michael Jackson",
                "collectionName": "The Essential Michael Jackson",
                "trackName": "Man In the Mirror",
                "collectionCensoredName": "The Essential Michael Jackson",
                "trackCensoredName": "Man In the Mirror",
                "artistViewUrl": "https://music.apple.com/us/artist/michael-jackson/32940?uo=4",
                "collectionViewUrl": "https://music.apple.com/us/album/man-in-the-mirror/159292399?i=159294478&uo=4",
                "trackViewUrl": "https://music.apple.com/us/album/man-in-the-mirror/159292399?i=159294478&uo=4",
                "previewUrl": "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview111/v4/56/a3/ca/56a3cadd-95ef-4139-a58f-48a3d53dff6c/mzaf_3097025142429158920.plus.aac.p.m4a",
                "artworkUrl30": "https://is2-ssl.mzstatic.com/image/thumb/Music127/v4/8a/65/be/8a65bef2-f23d-e43d-9124-f5e4293513f7/source/30x30bb.jpg",
                "artworkUrl60": "https://is2-ssl.mzstatic.com/image/thumb/Music127/v4/8a/65/be/8a65bef2-f23d-e43d-9124-f5e4293513f7/source/60x60bb.jpg",
                "artworkUrl100": "https://is2-ssl.mzstatic.com/image/thumb/Music127/v4/8a/65/be/8a65bef2-f23d-e43d-9124-f5e4293513f7/source/100x100bb.jpg",
                "collectionPrice": 16.99,
                "trackPrice": 1.29,
                "releaseDate": "1987-08-31T07:00:00Z",
                "collectionExplicitness": "notExplicit",
                "trackExplicitness": "notExplicit",
                "discCount": 2,
                "discNumber": 2,
                "trackCount": 17,
                "trackNumber": 5,
                "trackTimeMillis": 320905,
                "country": "USA",
                "currency": "USD",
                "primaryGenreName": "Pop",
                "isStreamable": true
            }]
    }
  """

    
      let mockIncorrectFeed =   """
    {
    "resultCount": 50,
    "results1": [
        {
            "wrapperType": "track",
            "kind": "song",
            "artistId": 32940,
            "collectionId": 159292399,
            "trackId": 159294478,
            "artistName": "Michael Jackson",
            "collectionName": "The Essential Michael Jackson",
            "trackName": "Man In the Mirror",
            "collectionCensoredName": "The Essential Michael Jackson",
            "trackCensoredName": "Man In the Mirror",
            "artistViewUrl": "https://music.apple.com/us/artist/michael-jackson/32940?uo=4",
            "collectionViewUrl": "https://music.apple.com/us/album/man-in-the-mirror/159292399?i=159294478&uo=4",
            "trackViewUrl": "https://music.apple.com/us/album/man-in-the-mirror/159292399?i=159294478&uo=4",
            "previewUrl": "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview111/v4/56/a3/ca/56a3cadd-95ef-4139-a58f-48a3d53dff6c/mzaf_3097025142429158920.plus.aac.p.m4a",
            "artworkUrl30": "https://is2-ssl.mzstatic.com/image/thumb/Music127/v4/8a/65/be/8a65bef2-f23d-e43d-9124-f5e4293513f7/source/30x30bb.jpg",
            "artworkUrl60": "https://is2-ssl.mzstatic.com/image/thumb/Music127/v4/8a/65/be/8a65bef2-f23d-e43d-9124-f5e4293513f7/source/60x60bb.jpg",
            "artworkUrl100": "https://is2-ssl.mzstatic.com/image/thumb/Music127/v4/8a/65/be/8a65bef2-f23d-e43d-9124-f5e4293513f7/source/100x100bb.jpg",
            "collectionPrice": 16.99,
            "trackPrice": 1.29,
            "releaseDate": "1987-08-31T07:00:00Z",
            "collectionExplicitness": "notExplicit",
            "trackExplicitness": "notExplicit",
            "discCount": 2,
            "discNumber": 2,
            "trackCount": 17,
            "trackNumber": 5,
            "trackTimeMillis": 320905,
            "country": "USA",
            "currency": "USD",
            "primaryGenreName": "Pop",
            "isStreamable": true
        }]
    }
    """

    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAlbumModalIsProperlyDecodedWhenProperDataIsReturned() throws {
        let data = Data(mockFeed.utf8)
        let expect = expectation(description: "Completion called succesfully")
        let networkClient = MockNetworkClient(data: data, error: nil)
        let albumLoader = RemoteAlbumsLoader(networkClient: networkClient, jsonDecoder: JSONDecoder())
        var expectedAlbums : [Album]? = nil
        albumLoader.getAlbums(searchTerm: "test") { (result) in
            guard case .success(let albums) = result else {
                expect.fulfill();
                return }
            expectedAlbums = albums
            expect.fulfill();
        }
                
        networkClient.get(url: "https://www.example.com") { result in
        }
        
        wait(for: [expect], timeout: 1)
        XCTAssertNotNil(expectedAlbums)
    }

    func testDecodeErrorIsWhenInproperDataIsReturned() throws {
        let data = Data(mockIncorrectFeed.utf8)
        let expect = expectation(description: "Completion called succesfully")
        let networkClient = MockNetworkClient(data: data, error: nil)
        let albumLoader = RemoteAlbumsLoader(networkClient: networkClient, jsonDecoder: JSONDecoder())
        var returnedError : CustomError? = nil
        albumLoader.getAlbums(searchTerm: "test") { (result) in
            guard case .failure(let error) = result else {
                expect.fulfill();
                return }
            returnedError = error
            expect.fulfill();
        }
                
        networkClient.get(url: "https://www.example.com") { result in
        }
        
        wait(for: [expect], timeout: 1)
        XCTAssertNotNil(returnedError)
        XCTAssertEqual(returnedError, CustomError.decodeError)

    }

    func testErrorIsWhenProperDataIsReturned() throws {
        let data = Data(mockIncorrectFeed.utf8)
        let expect = expectation(description: "Completion called succesfully")
        let networkClient = MockNetworkClient(data: data, error: CustomError.serverError)
        let albumLoader = RemoteAlbumsLoader(networkClient: networkClient, jsonDecoder: JSONDecoder())
        var returnedError : CustomError? = nil
        albumLoader.getAlbums(searchTerm: "test") { (result) in
            guard case .failure(let error) = result else {
                expect.fulfill();
                return }
            returnedError = error
            expect.fulfill();
        }
                
        networkClient.get(url: "https://www.example.com") { result in
        }
        
        wait(for: [expect], timeout: 1)
        XCTAssertNotNil(returnedError)
        XCTAssertEqual(returnedError, CustomError.serverError)

    }

}


class MockNetworkClient: HTTPClient {
    
    var data : Data?
    var error : CustomError?
    
    init(data:Data?,error:CustomError?) {
        self.data = data
        self.error = error
    }
    
    func get(url: String, completion: @escaping ((Result<Data, CustomError>) -> Void)) {
        if let error = error {
            completion(.failure(error))
        } else if let data = data {
            completion(.success(data))
        }
    }
    
}
