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
    var timer: Timer?
    @Published var price: Double = 0.0
 
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
    
    func refresh() {
        DispatchQueue.global().async {
            try? NetworkService.shared.fetch(url: self.url) { [weak self] (priceIndex: BitcoinQuote) -> Void in
                guard self != nil else { return }
                self!.price = priceIndex.bpi.usd.rateFloat
                print("\nBitcoinQuote:  \(self!.price) $USD")
            }
        }
    }
    
    @objc fileprivate func fireUpdateTimer() {
        print("BitcoinTracker Update Timer Fired")
        refresh()
    }

}

