//
//  HabitItem.swift
//  Habitual
//
//  Created by Ian Bailey on 16/10/2022.
//

import Foundation


enum RepeatsOn: Int, Codable {
    case noRepeat = 0
    case daily  = 1
    case weekly = 2
    case monthly = 3
}


struct HabitItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    var started = Date()
    var timesDone = 0
    var lastDone: Date
    var daysBetweenCompletions = 1.0
    var repeatsOn = RepeatsOn.noRepeat
    var repeatsDate = Date()
    var isDueNow: Bool {
        dateDue < Date()
    }
    var dateDue: Date {
        lastDone.addingTimeInterval(86_400 * daysBetweenCompletions)
    }

    var dueString: String {
        if isDueNow {
            return "Overdue"
        } else {
            let interval = dateDue.timeIntervalSince(Date())
            let day = 86_400.0
            switch interval {
            case -1.0..<day / 2:
                return "Due: \(dateDue.formatted(date: .omitted, time: .shortened))"
            case day / 2..<day * 7:
                return "Due: \(dateDue.formatted(Date.FormatStyle().weekday()))"
            default:
                return "Due: \(dateDue.formatted(date: .abbreviated, time: .omitted))"
            }

        }
    }

    var fractionDue: Double {
        // when a habit is overdue, or due now, the fractionDue is 1.0
        // when it's not due at all - just been donw, the fractioDue is 0.0
        if isDueNow {
            return 1.0
        } else {
            let daysSinceDone = Date().timeIntervalSince(lastDone) / 86_400
            assert(daysBetweenCompletions > 0.0)
            return daysSinceDone / daysBetweenCompletions
        }
    }
}


struct V01HabitItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    var started = Date()
    var timesDone = 0
    var lastDone: Date
    var daysBetweenCompletions = 1.0
}
