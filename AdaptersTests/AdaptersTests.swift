//
//  AdaptersTests.swift
//  AdaptersTests
//
//  Created by Ugur Unlu on 12/5/21.
//

import XCTest
@testable import Adapters

class AdaptersTests: XCTestCase {
    func test_buildURLString_shouldBeEqual() throws {
        let expectedURL = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=28910e2945e62c2cf4c3f00d6ffb20b1&tags=utrecht&per_page=10&page=1&format=json&nojsoncallback=1"
            
        let urlString = EndpointFactory.photos(tags: "utrecht", perPage: 10, page: 1)
            .absoluteString.removingPercentEncoding
        
        XCTAssertEqual(urlString, expectedURL)
    }
}

