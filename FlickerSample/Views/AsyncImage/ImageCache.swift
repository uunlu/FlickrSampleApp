//
//  ImageCache.swift
//  FlickerSample
//
//  Created by Ugur Unlu on 12/5/21.
//

import Foundation
import SwiftUI
 
final class ImageCache {
    private(set) var sizeLimit: Int {
        didSet {
            cache.totalCostLimit = sizeLimit
        }
    }
    private var cache: NSCache<NSString, UIImage>
    private let lock = NSLock()
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
        lock.lock()
        defer { lock.unlock() }
        
        cache.setObject(image, forKey: url.absoluteString as NSString, cost: image.fileSize)
    }
    
    func remove(for key: URL) {
        lock.lock()
        defer { lock.unlock() }
        
        cache.removeObject(forKey: key.absoluteString as NSString)
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

fileprivate extension UIImage {
    var fileSize: Int {
        guard let cgImage = cgImage else { return 0 }
        return cgImage.bytesPerRow * cgImage.height
    }
}
