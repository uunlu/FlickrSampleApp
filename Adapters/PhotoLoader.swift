//
//  PhotoLoader.swift
//  Adapters
//
//  Created by Ugur Unlu on 12/5/21.
//

import Foundation
import Combine

public protocol PhotoLoader {
    func load(request: PhotoRequest) -> AnyPublisher<ContainerPhotoViewModel, Error>
}
