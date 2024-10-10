//
//  ControlView.swift
//  Timer
//
//  Created by Kristian Emil on 16/09/2024.
//

import SwiftUI

struct ControlView: View {
    @ObservedObject var viewModel: TimerViewModel
    
    @State private var countdownInput = 0  // Default countdown value in seconds
    
    var body: some View {
        
        GeometryReader { geometry in
            
            HStack {
                // Reset Timer
                Button(action: {
                    if viewModel.currentTime == 0 {
                        countdownInput += 60
                        let countdownSeconds = countdownInput
                        viewModel.toggleMode(isCountdown: true, countdownFrom: countdownSeconds * 1000)
                        
                        // Ask permission to display notificaions
                        viewModel.requestNotificationPermissions()
                        
                    } else {
                        countdownInput = 0
                        viewModel.toggleMode(isCountdown: false, countdownFrom: countdownInput)
                        viewModel.resetTime()
                    }
                }) {
                    Text(viewModel.isCountingDown ? "Reset" : "Timer")
                        .animation(.snappy, value: viewModel.isCountingDown)
                }
                .frame(maxWidth: geometry.size.width / 3, alignment: .leading)
                .padding(.horizontal)
                
                
                // + - minutes
                HStack(spacing: geometry.size.width * 0.05) {
                    
                    // Minus 1 minute
                    Button(action: {
                        countdownInput -= 60
                        let countdownSeconds = countdownInput
                        viewModel.toggleMode(isCountdown: true, countdownFrom: countdownSeconds * 1000)
                        if countdownInput <= 1 {
                            countdownInput = 0
                            viewModel.toggleMode(isCountdown: false, countdownFrom: countdownInput)
                            viewModel.resetTime()
                        }
                    }) {
                        Text("–")
                    }
                    .buttonRepeatBehavior(.enabled)
                    .opacity(countdownInput <= 0 ? 0.5 : 1.0)
                    .disabled(countdownInput <= 0)
                    
                    
                    Button(action: {

                        if viewModel.currentTime == 0 {
//                            countdownInput += 60
                            let countdownSeconds = countdownInput
                            viewModel.toggleMode(isCountdown: true, countdownFrom: countdownSeconds * 1000)
                            
                        } else {
//                            countdownInput = 0
                            viewModel.toggleMode(isCountdown: false, countdownFrom: countdownInput)
                            viewModel.resetTime()
                        }
                        
                        
                    }) {
                        Image(systemName: "arrow.up")
                            .rotationEffect(Angle(degrees: viewModel.isCountingDown ? 180.0 : 0))
                            .animation(.bouncy(duration: 0.3), value: viewModel.isCountingDown)
                    }
                    .opacity(countdownInput <= 0 ? 0.5 : 1.0)
                    .disabled(countdownInput <= 0)
                    
                    
                    // Add 1 minute
                    Button(action: {
                        countdownInput += 60
                        let countdownSeconds = countdownInput
                        viewModel.toggleMode(isCountdown: true, countdownFrom: countdownSeconds * 1000)
                        
                        // Ask permission to display notificaions
                        viewModel.requestNotificationPermissions()
                        
                    }) {
                        Text("+")
                    }
                    .buttonRepeatBehavior(.enabled)
                    .disabled(countdownInput >= 3600)
                }
                .font(.largeTitle).bold()
                
                // Mute Switch for custom alarm sound
                HStack {
                    Button(action: {
                        viewModel.isMuted.toggle()  // Toggle mute state
                    }) {
                        Image(systemName: viewModel.isMuted ? "speaker.fill" : "speaker.wave.2.fill")
                            .opacity(viewModel.isMuted ? 0.5 : 1)
//                            .padding()
                    }
                }
                .frame(maxWidth: geometry.size.width / 3, alignment: .trailing)
                .padding(.horizontal)
                
            }
            .lineLimit(1)
            .minimumScaleFactor(0.2)
            .padding()
            .background(viewModel.isCountingDown ? Color.blue : Color.orange)
            .foregroundColor(viewModel.isCountingDown ? Color.white : Color.black)
            .cornerRadius(25)
            .font(.custom("Stormfaze", size: 25))
            .frame(width: geometry.size.width)
            
        }
    }
}

#Preview {
    ControlView(viewModel: TimerViewModel())
}


