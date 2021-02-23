//
//  AlbumTableViewCellTests.swift
//  GMArtistSearchTests
//
//  Created by Augustus Wilson on 02/18/21.
//  Copyright © 2021 Augustus Wilson. All rights reserved.
//

import XCTest

class AlbumTableViewCellTests: XCTestCase {

    let albumCell = AlbumTableViewCell()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAlbumCellHasImage() throws {
        XCTAssertNotNil(albumCell.albumImage)
        XCTAssertEqual(albumCell.albumImage.accessibilityIdentifier, "Album Image")
    }

    func testAlbumCellHasAlbumName() throws {
        XCTAssertNotNil(albumCell.albumName)
        XCTAssertEqual(albumCell.albumName.accessibilityIdentifier, "Album Name")
    }
    
    func testAlbumCellHasArtistName() throws {
        XCTAssertNotNil(albumCell.artistName)
        XCTAssertEqual(albumCell.artistName.accessibilityIdentifier, "Artist Name")
    }
    
    func testAlbumCellHasReleaseDate() throws {
        XCTAssertNotNil(albumCell.releaseDate)
        XCTAssertEqual(albumCell.releaseDate.accessibilityIdentifier, "Release Date")
    }

    
    func testAlbumCellHasGenre() throws {
        XCTAssertNotNil(albumCell.genre)
        XCTAssertEqual(albumCell.genre.accessibilityIdentifier, "Genre")
    }

    
    func testAlbumCellHasPrice() throws {
        XCTAssertNotNil(albumCell.trackPrice)
        XCTAssertEqual(albumCell.trackPrice.accessibilityIdentifier, "Track Price")
    }

    
    func testAlbumCellAssignsTheValuesFromPassedAlbum() throws {
        let album = Album(name: "Man In the Mirror", artistName: "Michael Jackson", imageUrl: "https://is2-ssl.mzstatic.com/image/thumb/Music127/v4/8a/65/be/8a65bef2-f23d-e43d-9124-f5e4293513f7/source/100x100bb.jpg", releaseDate: "1982-11-30T08:00:00Z", primaryGenreName: "Pop", trackPrice: 1.29)
        albumCell.refreshWith(album: album)
        
        XCTAssertEqual(albumCell.albumName.text, "Man In the Mirror")
        XCTAssertEqual(albumCell.artistName.text, "Michael Jackson")
        XCTAssertEqual(albumCell.releaseDate.text, "1982-11-30")
        XCTAssertEqual(albumCell.genre.text, "Pop")
        XCTAssertEqual(albumCell.trackPrice.text, "$ 1.29")
        
    }


}
