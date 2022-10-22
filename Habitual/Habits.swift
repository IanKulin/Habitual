//
//  Habits.swift
//  Habitual
//
//  Created by Ian Bailey on 16/10/2022.
//

import Foundation


class Habits: ObservableObject {

    @Published var items = [HabitItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            } else {
                print("JSON encoding fail")
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Habits") {
            if let decodedItems = try? JSONDecoder().decode([HabitItem].self, from: savedItems) {
                items = decodedItems
                return
            } else {
                print("JSON decoding fail - trying v0.1")
                var v01Items = [V01HabitItem]()
                if let decodedItems = try? JSONDecoder().decode([V01HabitItem].self, from: savedItems) {
                    v01Items = decodedItems
                    v01Items.forEach { oldHabit in
                        items.append(HabitItem(
                            id: oldHabit.id,
                            name: oldHabit.name,
                            started: oldHabit.started,
                            timesDone: oldHabit.timesDone,
                            lastDone: oldHabit.lastDone,
                            daysBetweenCompletions: oldHabit.daysBetweenCompletions
                        ))
                    }
                    return
                } else {
                    print("JSON decoding fail")
                }
            }
        }
        items = []
    }

    func markAsDone(habit: HabitItem) -> Bool {
        let habitIndex = items.firstIndex(of: habit)
        if let habitIndex = habitIndex {
            items[habitIndex].lastDone = Date()
            items[habitIndex].timesDone += 1
            return true
        } else {
            return false
        }
    }

    func sort() {
        items.sort { $0.dateDue < $1.dateDue }
    }


    deinit {
    }


}
