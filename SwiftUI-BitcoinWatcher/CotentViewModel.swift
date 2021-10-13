//
//  CotentViewModel.swift
//  SwiftUI-BitcoinWatcher
//
//  Created by Ethan on 13/10/2021.
//

import SwiftUI
import Foundation
import Combine


class CotentViewModel: ObservableObject {
    
    let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json")!
    var cancellable: AnyCancellable?
    var timer: Timer?
    @Published var price: Double = 0.0
    
//    let publisher: PassthroughSubject<Double, Never> = PassthroughSubject()
//    fileprivate var price: Double = 0.0 {
//        didSet {
//            print("Publisher send \(String(price))")
//            publisher.send(price)
//        }
//    }

    init(interval: Double) {
        
        self.timer = Timer.scheduledTimer(timeInterval: Double(interval),
                                          target: self,
                                          selector: #selector(fireUpdateTimer),
                                          userInfo: nil,
                                          repeats: true)
        self.timer!.fire()
    }
    
    deinit {
        self.timer?.invalidate()
    }
    
    func getCurrentPrice(_ callback: @escaping (BitcoinQuote) -> Void) {
        DispatchQueue.global().async {
            try? self.fetch({ (priceIndex: BitcoinQuote) -> Void in
                callback(priceIndex)
            })
        }
    }

}
 
// MARK: - private supplementaries
extension CotentViewModel {
    @objc fileprivate func fireUpdateTimer() {
        print("BitcoinTracker Update Timer Fired")
        DispatchQueue.global().async {
            try? self.fetch({ (priceIndex: BitcoinQuote) -> Void in
                print("\nBitcoinQuote")
                print("————————————————————————————————————————————————————")
                print("price $USD = \(self.price)")
                self.price = priceIndex.bpi.usd.rateFloat
            })
        }
    }
}

// MARK: - Networking
extension CotentViewModel {
    fileprivate func fetch<T: Decodable>(_ callback: @escaping (T) -> Void) throws {
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
