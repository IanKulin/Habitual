//
//  HabitItem.swift
//  Habitual
//
//  Created by Ian Bailey on 16/10/2022.
//

import Foundation


struct HabitItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    var started = Date()
    var timesDone = 0
    var lastDone: Date

    mutating func justDone() {
        timesDone += 1
        lastDone = Date()
    }
}
