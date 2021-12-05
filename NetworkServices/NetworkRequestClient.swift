//
//  NetworkRequestClient.swift
//  NetworkServices
//
//  Created by Ugur Unlu on 12/5/21.
//

import Foundation
import Combine
 
public protocol NetworkRequestClient {
    func get<T: Decodable>(from request: URLRequest) -> AnyPublisher<T, Error>
}
