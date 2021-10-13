//
//  ContentView.swift
//  SwiftUI-BitcoinWatcher
//
//  Created by Ethan on 13/10/2021.
//

import SwiftUI


struct ContentView: View {
    
   // private let viewModel = ContentViewModel()
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear() {
               // self.viewModel.setup()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
