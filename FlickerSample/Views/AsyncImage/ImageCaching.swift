//
//  ImageCaching.swift
//  FlickerSample
//
//  Created by Ugur Unlu on 12/5/21.
//

import Foundation
import SwiftUI

protocol ImageCaching {
    func item(for url: URL) -> UIImage?
    func insert(for url: URL, image: UIImage)
    func remove(for key: URL)
}
