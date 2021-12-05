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
    
    func test_cacheOnInsert_shouldHaveImage() {
        let sut = ImageCache.shared
        let url = URL(string: "https://some-url.com")!
        let imageToInsert = UIImage(systemName: "lock")!
        sut.insert(for: url, image: imageToInsert)
        let image = sut.item(for: url)
        XCTAssertNotNil(image)
        XCTAssertEqual(imageToInsert.cgImage?.bytesPerRow, image?.cgImage?.bytesPerRow)
    }
    
    func test_cacheOnRemove_shouldHaveNoImage() {
        let sut = ImageCache.shared
        let url = URL(string: "https://some-url.com")!
        let imageToInsert = UIImage(systemName: "lock")!
        sut.insert(for: url, image: imageToInsert)
        sut.remove(for: url)
        let image = sut.item(for: url)
        XCTAssertNil(image)
    }
    
    /// There is no need to test Apple provided frameworks and Apis
    /// Just to demo the behaviour of NSCache, which automatically clears up the memory, when the size limit set is exceeded.
    func test_cacheShouldHaveNilImage_when_sizeLimitBelowImageSize() {
        let sut = ImageCache.shared
        sut.configure(limit: 1)// 1 byte of cache size
        let url = URL(string: "https://some-url.com/")!
        let imageToInsert = UIImage(systemName: "lock")!
        sut.insert(for: url, image: imageToInsert)
        
        let url2 = URL(string: "https://some-url2.com/")!
        let imageToInsert2 = UIImage(systemName: "person")!
        sut.insert(for: url2, image: imageToInsert2)

        let exp = expectation(description: "wait for cache insertion")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let image = sut.item(for: url)
            XCTAssertNil(image)
            exp.fulfill()
        }
                                      
        wait(for: [exp], timeout: 1.1)
    }
}

