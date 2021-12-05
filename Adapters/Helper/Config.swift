//
//  Config.swift
//  Adapters
//
//  Created by Ugur Unlu on 12/5/21.
//

import Foundation

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
