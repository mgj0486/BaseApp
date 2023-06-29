//
//  ContentView.swift
//  MainApp
//
//  Created by dev team on 2023/06/26.
//  Copyright © 2023 perspective. All rights reserved.
//

import SwiftUI
import Core

struct ContentView: View {
    var logger: any NSLoggerProtocol {
        [ALoggerImpl(), BLoggerImpl()].randomElement()!
    }
    
    var body: some View {
        Text("Hello, World!")
            .onAppear {
                
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
