//
//  PhotoContainerViewModel.swift
//  FlickerSample
//
//  Created by Ugur Unlu on 12/5/21.
//

import Foundation
import Combine
import Adapters

final class PhotoContainerViewModel: ObservableObject {
    private let service: PhotoLoader
    
    init(service: PhotoLoader) {
        self.service = service
    }
}

class PhotoLoaderSpy: PhotoLoader {
    func load(request: PhotoRequest) -> AnyPublisher<ContainerPhotoViewModel, Error> {
        return Result.Publisher(.sample)
            .eraseToAnyPublisher()
    }
}
