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
    private var page = 1
    private var bag = Set<AnyCancellable>()
    @Published private(set) var model: ContainerPhotoViewModel {
        didSet {
            items.append(contentsOf: model.photos.map { .init(imageURL: URL(string: $0.imageURLString), title: $0.title)})
        }
    }
    @Published var items: [PhotoViewModel] = []
    @Published var searchText: String = "amsterdam"
    @Published var searchTerms: [String] = []
    @Published var isLoading = false
    
    init(service: PhotoLoader) {
        self.model = .init(total: 0, page: 0, photos: [])
        self.service = service
        bind()
    }
    
    func load() {
        isLoading = true
        let request = PhotoRequest(tags: searchText, perPage: perPage, page: page)
        service.load(request: request)
            .delay(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                    self.isLoading = false
                    break
                case .finished:
                    break
                }
            }) { data in
                self.model = data
                self.isLoading = false
            }
            .store(in: &bag)
    }
    
    func loadMore() {
        // Implement if max number of pages reached to not send load requests any more
        load()
    }
    
    private func bind() {
        $searchText
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { value in
                self.search(value)
            })
            .store(in: &bag)
    }
    
    private func search(_ text: String) {
        guard text.count > 2 else { return }
        page = 1
        model = .init(total: 0, page: 0, photos: [])
        items.removeAll()
        addHistory(text)
        load()
    }
    
    private func addHistory(_ searchText: String) {
        if searchTerms.last == searchText { return }
        searchTerms.append(searchText)
    }
}

#if DEBUG
class PhotoLoaderSpy: PhotoLoader {
    func load(request: PhotoRequest) -> AnyPublisher<ContainerPhotoViewModel, Error> {
        return Result.Publisher(.sample)
            .eraseToAnyPublisher()
    }
}
#endif
