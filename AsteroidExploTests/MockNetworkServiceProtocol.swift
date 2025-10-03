//
//  MockNetworkServiceProtocol.swift
//  AsteroidExplo
//
//  Created by user260596 on 10/3/25.
//
import XCTest
import Foundation

final class MockURLProtocol: URLProtocol {

    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            fatalError("Request handler is not set")
        }

        do {
            let (response, data) = try handler(request)

            // Simulate a small network delay so loading indicator appears
            Thread.sleep(forTimeInterval: 1.0) // 1 second

            self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            self.client?.urlProtocol(self, didLoad: data)
            self.client?.urlProtocolDidFinishLoading(self)
        } catch {
            self.client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {}
}
