//
//  SuperTimeWidget.swift
//  SuperTimeWidget
//
//  Created by Kristian Emil on 10/10/2024.
//

import WidgetKit
import SwiftUI

struct SuperTimeWidget: Widget {
    let kind: String = "SuperTimeWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            SuperTimeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("SuperTime Widget")
        .description("Displays the current state of the timer or stopwatch.")
        .supportedFamilies([.systemSmall, .systemMedium]) //  .systemLarge for an even bigger widget
    }
}

// 3. Define the Widget Entry View
struct SuperTimeWidgetEntryView: View {
    var entry: Provider.Entry  // The 'Entry' type is inferred from 'Provider'
    
    var body: some View {
        ZStack {
            VStack {
                Text("SuperTime")
                    .font(.custom("Stormfaze", size: 12))
                
                HStack {
                    // Display the current state of the timer
                    if entry.timerState == "paused" {
                        Text("Paused")
                    } else if entry.timerState == "running" {
                        Text("Running")
                    } else {
                        Text("Start")
                    }
                    
//                    Text(entry.timerState == "stopped" ? "Start" : entry.timerState)
//                    Text(entry.timerValue) // Cannot update quick enough
//                    Text("Mode: \(entry.timerMode)")
                }
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            }
            .foregroundColor(entry.timerState == "paused" ? .black : .white)
            .font(.custom("Stormfaze", size: 42))
            .containerBackground(for: .widget) {
                if entry.timerState == "paused" {
                    Color.yellow
                } else if entry.timerState == "running" {
                    Color.red
                } else {
                    Color.black
                }
            }
        }
    }
}
