//
//  RemotePhoto.swift
//  Entities
//
//  Created by Ugur Unlu on 12/5/21.
//

import Foundation

// MARK: - RemotePhoto
public struct RemotePhoto: Decodable {
    public let photos: Photos
    public let stat: String
}

// MARK: - Photos
public struct Photos: Decodable {
    public let page: Int
    public let pages: Int
    public let perpage: Int
    public let total: Int
    public let photo: [Photo]
}

// MARK: - Photo
public struct Photo: Decodable {
    public init(id: String, owner: String, secret: String, server: String, farm: Int, title: String) {
        self.id = id
        self.owner = owner
        self.secret = secret
        self.server = server
        self.farm = farm
        self.title = title
    }
    
    public let id: String
    public let owner: String
    public let secret, server: String
    public let farm: Int
    public let title: String
}
