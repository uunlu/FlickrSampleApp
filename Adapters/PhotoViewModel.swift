//
//  PhotoViewModel.swift
//  Adapters
//
//  Created by Ugur Unlu on 12/5/21.
//

import Foundation

public struct PhotoViewModel: Identifiable {
    public var id: String { UUID().uuidString }
    public let imageURLString: String
    public let title: String
}
