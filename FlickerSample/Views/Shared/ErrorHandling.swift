//
//  ErrorHandliing.swift
//  FlickerSample
//
//  Created by Ugur Unlu on 12/5/21.
//

import Foundation

protocol ErrorHandling {
    var hasError: Bool { get }
    var errorMessage: String { get }
}
