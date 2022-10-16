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
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Habits") {
            if let decodedItems = try? JSONDecoder().decode([HabitItem].self, from: savedItems) {
                items = decodedItems
                return
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


    deinit {
    }


}
