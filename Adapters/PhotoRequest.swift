//
//  PhotoRequest.swift
//  Adapters
//
//  Created by Ugur Unlu on 12/5/21.
//

import Foundation

public struct PhotoRequest {
    public init(tags: String, perPage: Int, page: Int) {
        self.tags = tags
        self.perPage = perPage
        self.page = page
    }
    
    public let tags: String
    public let perPage: Int
    public let page: Int
}
