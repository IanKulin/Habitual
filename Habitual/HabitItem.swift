//
//  HabitItem.swift
//  Habitual
//
//  Created by Ian Bailey on 16/10/2022.
//

import Foundation


struct HabitItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    var started = Date()
    var timesDone = 0
    var lastDone: Date
    var daysBetweenCompletions = 1.0
    var isDueNow: Bool {
        dateDue < Date()
    }
    var dateDue: Date {
        lastDone.addingTimeInterval(86_400 * daysBetweenCompletions)
    }
}
