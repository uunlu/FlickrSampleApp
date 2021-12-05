//
//  NetworkServicesTests.swift
//  NetworkServicesTests
//
//  Created by Ugur Unlu on 12/5/21.
//

import XCTest
import Combine
@testable import NetworkServices

class NetworkServicesTests: XCTestCase {
    func test_onInitNetworkRequest_urlRequestsShouldBeEmpty() throws {
        let sut = NetworkRequestSpy(result: .success(Data()))
        XCTAssertTrue(sut.requests.isEmpty)
    }

    func test_onSingleOrMoreNetworkRequest_urlRequestShouldBeNotEmpty() {
        let sut = NetworkRequestSpy(result: .success(Data()))
        let result: AnyPublisher<SampleDecodable, Error> = sut.get(from: URLRequest.sample)
        XCTAssertFalse(sut.requests.isEmpty)
        XCTAssertNotNil(result)
    }
}

public protocol NetworkRequestClient {
    func get<T: Decodable>(from request: URLRequest) -> AnyPublisher<T, Error>
}

class NetworkRequestSpy: NetworkRequestClient {
    private let result: Result<Data, Error>
    private (set) var session: URLSession
    var requests: [URLRequest] = []
    
    init(result: Result<Data, Error>, session: URLSession = .shared) {
        self.result = result
        self.session = session
    }

    func get<T>(from request: URLRequest) -> AnyPublisher<T, Error> where T : Decodable {
        requests.append(request)
        return result.publisher
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

extension URLRequest {
    static var sample: URLRequest {
        URLRequest(url: URL(string: "https://some-url.com")!)
    }
}

struct SampleDecodable: Codable {
    let title: String
}
