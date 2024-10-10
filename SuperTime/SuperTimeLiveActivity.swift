//
//  SuperTimeLiveActivity.swift
//  Timer
//
//  Created by Kristian Emil on 23/09/2024.
//

import WidgetKit
import SwiftUI

//@available(iOS 16.1, *)
struct SuperTimeLiveActivity: Widget {
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: SuperTimeAttributes.self) { context in
            // Lock screen/banner UI
            
            ZStack {
                HStack {
                    Spacer()
                    Circle()
                        .fill(context.state.endDate > .now ? Color.blue : Color.orange)
                        .scaleEffect(2, anchor: .leading)
                }
                
                HStack {
                    Spacer()
                    VStack {
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("SuperTime")
                            // Using date and timer style to show time as a countdown or stopwatch
                            
                            if context.state.endDate > .now {
                                Text(context.state.endDate, style: .timer) // Countdown mode
                                    .font(.custom("Stormfaze", size: 42))
                                
                            } else {
                                Text(context.state.startDate, style: .timer) // Stopwatch mode
                                    .font(.custom("Stormfaze", size: 42))
                            }
                        }
                    }
                    .font(.custom("Stormfaze", size: 22))
                    .contentTransition(.numericText())
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .padding()
                    
                    Spacer()
                }
                
            }
            .foregroundStyle((context.state.endDate > .now ? Color.black : Color.white))
            .activityBackgroundTint(context.state.endDate > .now ? Color.orange : Color.blue)
            .frame(height: 100)
            
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI for dynamic island
                DynamicIslandExpandedRegion(.leading) {
                    Circle()
                        .fill(context.state.endDate > .now ? Color.orange : Color.blue)
                        .frame(height: 50)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    VStack (alignment: .trailing){
                        
                        Text("SuperTime")
                        
                        if context.state.endDate > .now {
                            Text(context.state.endDate, style: .timer) // Countdown mode
                                .font(.custom("Stormfaze", size: 42))
                            
                        } else {
                            Text(context.state.startDate, style: .timer) // Stopwatch mode
                                .font(.custom("Stormfaze", size: 42))
                            
                        }
                    }
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .font(.custom("Stormfaze", size: 22))
                    .contentTransition(.numericText())
                    .padding(.horizontal)
                    .frame(height: 50)
                    
                }
                DynamicIslandExpandedRegion(.bottom) {
                    // Buttom
                }
            } compactLeading: {
                // Show either countdown or stopwatch time in compact mode
                Circle()
                    .fill(context.state.endDate > .now ? Color.orange : Color.blue)
                
            } compactTrailing: {
                
                
            } minimal: {
                Circle()
                    .fill(context.state.endDate > .now ? Color.orange : Color.blue)
                
            }
            .keylineTint(context.state.endDate > .now ? Color.orange : Color.blue)
            
        }
    }
}
