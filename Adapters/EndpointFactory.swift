//
//  EndpointFactory.swift
//  Adapters
//
//  Created by Ugur Unlu on 12/5/21.
//

import Foundation

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
