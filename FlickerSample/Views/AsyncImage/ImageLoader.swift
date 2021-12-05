//
//  ImageLoader.swift
//  FlickerSample
//
//  Created by Ugur Unlu on 12/5/21.
//

import Foundation
import Combine
import SwiftUI

final class ImageLoader: ObservableObject, ImageLoading {
    @Published private(set) var image: UIImage?
    private var cancellable: AnyCancellable?
    private let imageCache: ImageCaching
    
    init(imageCache: ImageCaching = ImageCache.shared) {
        self.imageCache = imageCache
    }
    
    deinit {
        cancel()
    }
    
    func load(url: URL?){
        guard let url = url else { return }
        if let image = imageCache.item(for: url) {
            self.image = image
            return
        }
        cancellable = URLSession.shared
            .dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveOutput: {[unowned self] image in
                guard let image = image else { return }
                self.imageCache.insert(for: url, image: image)
            })
            .receive(on: RunLoop.main)
            .sink { [weak self] in
                self?.image = $0
            }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}
