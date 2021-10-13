//
//  ContentView.swift
//  SwiftUI-BitcoinWatcher
//
//  Created by Ethan on 13/10/2021.
//

import SwiftUI


struct ContentView: View {
    
    @StateObject private var viewModel = CotentViewModel(interval: 3600.0)
    
    var body: some View {
        
        NavigationView {
            
                VStack(alignment: .center, spacing: 20.0) {
                
                    Text("BTC CURRENT PRICE")
                        .font(.system(size: 23,
                                      weight: .semibold,
                                      design: .default))
                        .foregroundColor(.orange)
                    
                    HStack(alignment: .center, spacing: 10) {
                        Text("\(viewModel.price, specifier: "%.2f")")
                            .font(.system(size: 35,
                                          weight: .heavy,
                                          design: .default))
                            .foregroundColor(Color.blue)
                        Text("$")
                            .font(.system(size: 28,
                                          weight: .semibold,
                                          design: .default))
                            .foregroundColor(.blue)
                    }
                    
                    Button(action: {
                        viewModel.refresh()
                    }) {
                        HStack {
                            Image(systemName: "arrow.clockwise")
                            Text("update now")
                                .font(.system(size: 17,
                                              weight: .semibold,
                                              design: .default))
                                .fontWeight(.regular)
                        }
                        .frame(width: 150, height: 20, alignment: .center)
                        .padding(10.0)
                        .background(Color(red: 0.8, green: 0.1, blue: 0.05))
                        .foregroundColor(Color.white)
                        .clipShape(Capsule())
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
            .preferredColorScheme(.dark)
    }
}
