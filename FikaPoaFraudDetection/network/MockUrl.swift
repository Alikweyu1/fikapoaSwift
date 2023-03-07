//
//  MockUrl.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 11/03/2023.
//

import Foundation
import Combine

class MockUrls : URLProtocol {
    static var requestHandler: ((URLRequest) throws ->(HTTPURLResponse,Data))?
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    override func stopLoading() {
        
    }
    override func startLoading() {
        guard let handler = MockUrls.requestHandler else{
            return
        }
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch{
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
}
@available(iOS 13.0, *)
func setMockProtocol() {
    MockUrls.requestHandler = { request in
        let  exampledata =
       """
        {
        "base":"USD"
        
        }
        """
            .data(using: .utf8)!
        let response = HTTPURLResponse.init(url: request.url!, statusCode: 200, httpVersion: "2.0", headerFields: nil)!
        return (response,exampledata)
    }
    var cancellable = Set<AnyCancellable>()
    let url = URL(string: "someUrl")!
    let sessionConfigurations = URLSessionConfiguration.ephemeral
    sessionConfigurations.protocolClasses = [MockUrls.self]
    let session = URLSession(configuration: sessionConfigurations)
    session.dataTaskPublisher(for: url)
        .map{$0.data}
        .decode(type: Object.self, decoder: JSONDecoder())
        .sink{ completion in
            print(completion)
            
        } receiveValue: { value in
            print(value)
        }.store(in: &cancellable)
}
struct Object:Codable{
    let base: String
}

