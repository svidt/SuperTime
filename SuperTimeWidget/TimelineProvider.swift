//
//  TimelineProvider.swift
//  Timer
//
//  Created by Kristian Emil on 10/10/2024.
//

import WidgetKit
import SwiftUI

// 1. Define the Entry struct
struct SimpleEntry: TimelineEntry {
    let date: Date
    let timerValue: String
    let timerState: String  // "running", "paused", or "stopped"
    let timerMode: String   // "stopwatch" or "timer"
}

// 2. Define the Provider struct
struct Provider: TimelineProvider {
    
    // Returns a placeholder entry when the widget is in an unloaded state
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), timerValue: "00:00:00", timerState: "stopped", timerMode: "stopwatch")
    }

    // Returns a snapshot entry for the widget gallery
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date(), timerValue: "00:00:00", timerState: "stopped", timerMode: "stopwatch")
        completion(entry)
    }
    
    // In your widget extension
    func getCurrentTimerValue() -> String {
        let sharedDefaults = UserDefaults(suiteName: "group.supertime")
        return sharedDefaults?.string(forKey: "timerValue") ?? "00:00:00"
    }

    func getCurrentTimerState() -> String {
        let sharedDefaults = UserDefaults(suiteName: "group.supertime")
        return sharedDefaults?.string(forKey: "timerState") ?? "stopped"
    }

    func getCurrentTimerMode() -> String {
        let sharedDefaults = UserDefaults(suiteName: "group.supertime")
        return sharedDefaults?.string(forKey: "timerMode") ?? "stopwatch"
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        var entries: [SimpleEntry] = []

        let currentDate = Date()
        let timerValue = getCurrentTimerValue()
        let timerState = getCurrentTimerState()
        let timerMode = getCurrentTimerMode()

        let entry = SimpleEntry(date: currentDate, timerValue: timerValue, timerState: timerState, timerMode: timerMode)
        entries.append(entry)

        let nextUpdateDate = Calendar.current.date(byAdding: .second, value: 1, to: currentDate)!
        let timeline = Timeline(entries: entries, policy: .after(nextUpdateDate))
        completion(timeline)
    }
    
    
}
