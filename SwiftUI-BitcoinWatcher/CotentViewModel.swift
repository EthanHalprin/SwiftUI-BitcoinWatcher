//
//  CotentViewModel.swift
//  SwiftUI-BitcoinWatcher
//
//  Created by Ethan on 13/10/2021.
//

import Foundation
import SwiftUI


class ContentViewModel {

    private let backgroundKey = "com.bitcoin.watcher"
    fileprivate var backgroundService: BackgroundModeService? = nil
    
    func setup() {
        backgroundService = BackgroundModeService(key: backgroundKey)
    }
}
