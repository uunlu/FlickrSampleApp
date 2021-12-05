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

struct Config {
    static var scheme = "https"
    static var baseURL = "www.flickr.com"
    static var path = "/services/rest/"
    static var apiKey = "28910e2945e62c2cf4c3f00d6ffb20b1"
    static var format = ("json", "1")
    enum Methods: String {
        case photos = "flickr.photos.search"
    }
}

struct EndpointFactory {
    static func photos(tags: String, perPage: Int, page: Int) -> URL {
        buildURL(method: Config.Methods.photos.rawValue, tags: tags, perPage: perPage, page: page).url!
    }
    
    static private func buildURL(method: String, tags: String, perPage: Int, page: Int) -> URLComponents {
        var components = URLComponents()
        components.scheme = Config.scheme
        components.host = Config.baseURL
        components.path = Config.path
        components.queryItems = [
            URLQueryItem(name: "method", value: method),
            URLQueryItem(name: "api_key", value: Config.apiKey),
            URLQueryItem(name: "tags", value: tags),
            URLQueryItem(name: "per_page", value: "\(perPage)"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "format", value: Config.format.0),
            URLQueryItem(name: "nojsoncallback", value: Config.format.1),
        ]
        
        return components
    }
}
