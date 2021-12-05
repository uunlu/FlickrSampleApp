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
    
    func test_urlRequestShouldFail_whenDataDecodeFails() throws {
        let sut = NetworkRequestSpy(result: .success(Data()))
        _=sut.get(from: URLRequest.sample)
            .tryMap { $0 as SampleDecodable }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(_):
                    break
                case .finished:
                    XCTFail()
                    break
                }
            }) { _ in
            }
            
        XCTAssertFalse(sut.requests.isEmpty)
    }
    
    func test_urlRequestShouldScuceed_whenDataInDecodableFormat() throws {
        let model = SampleDecodable(title: "title")
        let data = try! JSONEncoder().encode(model)
        let sut = NetworkRequestSpy(result: .success(data))
        _=sut.get(from: URLRequest.sample)
            .tryMap { $0 as SampleDecodable }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(_):
                    XCTFail()
                case .finished:
                    break
                }
            }) { response in
                XCTAssertTrue(model.title == response.title)
            }
            
        XCTAssertFalse(sut.requests.isEmpty)
    }
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
