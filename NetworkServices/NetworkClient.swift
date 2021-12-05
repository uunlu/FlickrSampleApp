//
//  NetworkClient.swift
//  NetworkServices
//
//  Created by Ugur Unlu on 12/5/21.
//

import Foundation
import Combine

public class NetworkClient: NetworkRequestClient {
    private var session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func get<T>(from request: URLRequest) -> AnyPublisher<T, Error> where T : Decodable {
        session
            .dataTaskPublisher(for: request)
            .tryCompactMap { (data, response) in
                guard let htttpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                guard 200..<300 ~= htttpResponse.statusCode else {
                    throw NetworkError.notAuthorized
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
