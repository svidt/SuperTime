//
//  ContentView.swift
//  Timer
//
//  Created by Kristian Emil on 15/09/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
//    @StateObject var viewModel = TimerViewModel()
    @ObservedObject var viewModel: TimerViewModel
    
    @AppStorage("aboutToShowWelcomeScreen") var aboutToShowWelcomeScreen = true
    
    @State var invertColor: Bool = false
    
    // A simple stopwatch app with a striking design
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black)
                .ignoresSafeArea()

            GeometryReader(content: { geometry in
                if geometry.size.height > geometry.size.width {
                    
                    // Portrait view
                    VStack {
                        TimerView(viewModel: viewModel)
                            .frame(height: geometry.size.height * (viewModel.isRunning ? 0.75 : viewModel.isPaused ? 0.70 : 0.6))
                        
                        ControlView(viewModel: viewModel)
                            .frame(height: geometry.size.height * (viewModel.isRunning || viewModel.isPaused ? 0.0 : 0.1))
                            .scaleEffect(viewModel.isRunning || viewModel.isPaused ? 0.0 : 1, anchor: .top)
                            .opacity(viewModel.isRunning || viewModel.isPaused ? 0.0 : 1)
                        
                        ButtonView(viewModel: viewModel)
                            .frame(height: geometry.size.height * (viewModel.isRunning || viewModel.isPaused ? 0.25 : 0.3))
                        
                    }
                } else {
                    
                    // Landscape view
                    HStack {
                        
                        TimerView(viewModel: viewModel)
                            .frame(width: geometry.size.width * (viewModel.isRunning || viewModel.isPaused ? 0.70 : 0.5))
                            .clipped()
                        
                        VStack {
                            
                            ControlView(viewModel: viewModel)
                                .frame(height: geometry.size.height * (viewModel.isRunning || viewModel.isPaused ? 0.0 : 0.2))
                                .scaleEffect(viewModel.isRunning || viewModel.isPaused ? 0.0 : 1)
                                .opacity(viewModel.isRunning || viewModel.isPaused ? 0.0 : 1)
                            
                            ButtonView(viewModel: viewModel)
                                .frame(width: geometry.size.width * (viewModel.isRunning || viewModel.isPaused ? 0.30 : 0.5), height: geometry.size.height * (viewModel.isRunning || viewModel.isPaused ? 1 : 0.6))

                        }
                    }
                }
            })
            .animation(.bouncy(duration: 0.3), value: viewModel.isRunning)
            .animation(.bouncy(duration: 0.3), value: viewModel.isPaused)
            .fullScreenCover(isPresented: $aboutToShowWelcomeScreen) { WelcomeScreen(viewModel: viewModel) }
        }
        .ignoresSafeArea()
        .persistentSystemOverlays(.hidden)
    }
}

#Preview {
    ContentView(viewModel: TimerViewModel())
}
