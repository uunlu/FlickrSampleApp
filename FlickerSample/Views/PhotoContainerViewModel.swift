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
    private let perPage = 20
    private let page = 1
    private var bag = Set<AnyCancellable>()
    @Published private(set) var model: ContainerPhotoViewModel {
        didSet {
            items.append(contentsOf: model.photos.map { .init(imageURL: $0.imageURLString, title: $0.title)})
        }
    }
    @Published private(set) var items: [PhotoViewModel] = []
    init(service: PhotoLoader) {
        self.model = .init(total: 0, page: 0, photos: [])
        self.service = service
        
    }
    
    func load() {
        let request = PhotoRequest(tags: "utrecht", perPage: perPage, page: page)
        service.load(request: request)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                    break
                case .finished:
                    break
                }
            }) { data in
                self.model = data
            }
            .store(in: &bag)
    }
}

class PhotoLoaderSpy: PhotoLoader {
    func load(request: PhotoRequest) -> AnyPublisher<ContainerPhotoViewModel, Error> {
        return Result.Publisher(.sample)
            .eraseToAnyPublisher()
    }
}

struct PhotoViewModel: Identifiable {
    let id: String = UUID().uuidString
    let imageURL: String
    let title: String
}
