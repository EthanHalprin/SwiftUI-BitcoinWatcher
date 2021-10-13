//
//  Network.swift
//  SwiftUI-BitcoinWatcher
//
//  Created by Ethan on 13/10/2021.
//

import Foundation
import Combine

class NetworkService {
    var cancellable: AnyCancellable?

    static var shared = NetworkService()
    private init() {}
}

extension NetworkService {
    func fetch<T: Decodable>(url: URL, _ callback: @escaping (T) -> Void) throws {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                return element.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in
                    //print ("Received completion: \($0).")
                  },
                  receiveValue: { T in
                    //print ("Received: \(T)")
                    callback(T)
            })
    }
}
