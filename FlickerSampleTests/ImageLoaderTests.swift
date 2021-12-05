//
//  ImageLoaderTests.swift
//  FlickerSampleTests
//
//  Created by Ugur Unlu on 12/5/21.
//

import Foundation
import XCTest
import Combine
@testable import FlickerSample

class ImageLoaderTests: XCTestCase {
    var bag: Set<AnyCancellable>!
    override func setUp() {
        bag = Set<AnyCancellable>()
    }
    func test_onInit_shouldLoadImage() throws {
        let data = UIImage(systemName: "lock")!.pngData()!
        let sut = ImageLoaderSpy(output: data)
        sut.load(url: URL(string: "https://some-url.com")!)
        
        let exp = expectation(description: "wait for image loading")
        sut.$image
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { image in
                XCTAssertNotNil(image)
                
                XCTAssertEqual(UIImage(data: data)?.cgImage?.bytesPerRow, image?.cgImage?.bytesPerRow)
                exp.fulfill()
            })
            .store(in: &bag)
        
        wait(for: [exp], timeout: 1.1)
    }
}


class ImageLoaderSpy:ObservableObject, ImageLoading {
    @Published var image: UIImage?
    let cacheLoader = ImageCache.shared
    var cancellable: AnyCancellable?
    var output: Data
    var bag = Set<AnyCancellable>()
    internal init(output: Data) {
        self.output = output
    }
    
    func load(url: URL?) {
        guard let url = url else { return }
            
        if let image = cacheLoader.item(for: url) {
            self.image = image
            return
        }

        cancellable = Just(output)
            .map { UIImage(data: $0) }
            .replaceError(with: nil)
            .handleEvents(receiveOutput: {[unowned self] image in
                guard let image = image else { return }
                self.cacheLoader.insert(for: url, image: image)
                self.image = image
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

