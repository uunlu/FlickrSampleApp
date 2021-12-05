//
//  PhotoAdapter.swift
//  Adapters
//
//  Created by Ugur Unlu on 12/5/21.
//

import Foundation
import Combine
import NetworkServices
import Entities

public struct PhotoAdapter: PhotoLoader {
    let service: NetworkRequestClient
    public init(service: NetworkRequestClient) {
        self.service = service
    }
    
    public func load(request: PhotoRequest) -> AnyPublisher<ContainerPhotoViewModel, Error> {
        let endpoint = EndpointFactory.photos(tags: request.tags, perPage: request.perPage, page: request.page)
        let urlRequest = URLRequest(url: endpoint)
        let photosPublisher: AnyPublisher<RemotePhoto, Error> = service.get(from: urlRequest)
        
        return photosPublisher
            .tryMap { response in
                return response.photos
            }
            .map {
                return mapToContainerViewModel(from: $0)
            }
        
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    private func mapToContainerViewModel(from photos: Photos) -> ContainerPhotoViewModel {
        let photoViewModels = photos.photo
            .map { mapToViewModel(from: $0) }
        return .init(total: photos.total, page: photos.page, photos: photoViewModels)
    }
    
    private func mapToViewModel(from photo: Photo)-> PhotoViewModel {
        let urlString = "https://farm\(photo.farm).static.flickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"
        return .init(imageURLString: urlString, title: photo.title)
    }
}
