//
//  TimerApp.swift
//  Timer
//
//  Created by Kristian Emil on 15/09/2024.
//

import SwiftUI

@main
struct TimerApp: App {
    
    @StateObject var viewModel = TimerViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
