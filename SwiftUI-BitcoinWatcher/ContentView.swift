//
//  ContentView.swift
//  SwiftUI-BitcoinWatcher
//
//  Created by Ethan on 13/10/2021.
//

import SwiftUI


struct ContentView: View {
    
    @StateObject private var viewModel = CotentViewModel(interval: 6.0)
    
    var body: some View {
        
        NavigationView {
            

                VStack(alignment: .center, spacing: 20.0) {
                
                    Text("BTC CURRENT PRICE")
                        .font(.system(size: 30,
                                      weight: .semibold,
                                      design: .default))
                        .foregroundColor(.orange)
                    
                    HStack(alignment: .center, spacing: 10) {
                        Text("\(viewModel.price, specifier: "%.2f")")
                            .font(.system(size: 30,
                                          weight: .heavy,
                                          design: .default))
                            .foregroundColor(Color.blue)
                        Text("$")
                            .font(.system(size: 25,
                                          weight: .semibold,
                                          design: .default))
                            .foregroundColor(.blue)
                    }
                }
                .offset(x: 0, y: -50)
                .padding()
                .navigationTitle("Bitcoin")

        }.ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
