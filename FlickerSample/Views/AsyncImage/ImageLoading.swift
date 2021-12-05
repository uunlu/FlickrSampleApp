//
//  ImageLoading.swift
//  FlickerSample
//
//  Created by Ugur Unlu on 12/5/21.
//

import Foundation
import SwiftUI

protocol ImageLoading {
    var image: UIImage? { get }
    func load(url: URL?)
    func cancel()
}
