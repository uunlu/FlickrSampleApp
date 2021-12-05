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
