//
//  ImageCacheTests.swift
//  FlickerSampleTests
//
//  Created by Ugur Unlu on 12/5/21.
//

import Foundation
import XCTest
@testable import FlickerSample

class ImageCacheTests: XCTestCase {
    func test_initWithDefaultLimit() {
        let sut = ImageCache.shared
        XCTAssertEqual(sut.sizeLimit, 5 * 1024 * 1024)
    }
    
    func test_shouldChangeCacheLimit() {
        let sut = ImageCache.shared
        let sizeLimit = 1024 * 1024
        sut.configure(limit: sizeLimit)
        XCTAssertEqual(sut.sizeLimit, sizeLimit)
    }
    
    func test_cacheOnInit_shouldHaveNoImage() {
        let sut = ImageCache.shared
        let image = sut.item(for: URL(string: "https://some-url.com")!)
        XCTAssertNil(image)
    }
}

class ImageCache {
    private(set) var sizeLimit: Int {
        didSet {
            cache.totalCostLimit = sizeLimit
        }
    }
    private var cache: NSCache<NSString, UIImage>
    static let defaultSizeLimit = 5 * 1024 * 1024
    static let shared: ImageCache = ImageCache(sizeLimit: defaultSizeLimit)
    
    private init(cache: NSCache<NSString, UIImage> = NSCache(), sizeLimit: Int) {
        self.sizeLimit = sizeLimit
        self.cache = cache
    }
    
    func configure(limit: Int) {
        self.sizeLimit = limit
    }
}

extension ImageCache: ImageCaching {
    func insert(for url: URL, image: UIImage) {
    }
    
    func remove(for key: URL) {
    }
    
    func item(for url: URL) -> UIImage? {
        return cache.object(forKey: url.absoluteString as NSString)
    }
}

protocol ImageCaching {
    func item(for url: URL) -> UIImage?
    func insert(for url: URL, image: UIImage)
    func remove(for key: URL)
}
