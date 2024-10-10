//
//  SuperTimeAttributes.swift
//  Timer
//
//  Created by Kristian Emil on 23/09/2024.
//

import ActivityKit
import SwiftUI

struct SuperTimeAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var startDate: Date
        var endDate: Date
        var isRunning: Bool
    }
    
    var timerType: String
}
