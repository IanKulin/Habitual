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
    var due: Bool {
        lastDone.timeIntervalSince(Date.now) > (daysBetweenCompletions * 60 * 60 * 24)
    }
}
