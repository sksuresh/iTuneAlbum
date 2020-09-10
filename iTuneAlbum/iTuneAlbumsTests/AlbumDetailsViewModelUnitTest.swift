//
//  AlbumDetailsViewModelUnitTest.swift
//  iTueneAlbumsTests
//
//  Created by Suresh Dokula on 09/10/20.
//  Copyright © 2020 suresh. All rights reserved.
//

import XCTest
@testable import iTuneAlbums

class AlbumDetailsViewModelUnitTest: XCTestCase {


    func testImgDownloadForAlbum() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var viewModel =  AlbumDetailsViewModel(album: nil, imageCache: MockDataManager.imageCache,delegate: nil)
        MockDataManager().getFeeds { (feed:Feeds?, responseResult:ResponseResult?) in
            XCTAssertNotNil(feed, "Feeds Should not be empty")
            XCTAssertNotNil(feed?.feed, "Feed Should not be empty")
            XCTAssertNotNil(feed?.feed?.results, "results Should not be empty")
            XCTAssertNotNil(feed?.feed?.results?.first, "Album Should not be empty")
            XCTAssertNotNil(feed?.feed?.results?.first?.genres, "geners Should not be empty")
            viewModel.album = feed?.feed?.results?.first
            XCTAssertNotNil(feed?.feed?.results?.first?.artworkUrl100, "img url Should not be empty")
            viewModel.getImage(imgUrl:feed?.feed?.results?.first?.artworkUrl100 ?? "", completion: { (data:Data?) in
                XCTAssertNotNil(data, "img data Should not be empty")
            })
        }
        
    }

}
