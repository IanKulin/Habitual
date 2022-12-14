//
//  AddView.swift
//  Habitual
//
//  Created by Ian Bailey on 16/10/2022.
//

import SwiftUI


struct AddView: View {
    @ObservedObject var habitsCollection: Habits
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var daysBetween = 1.0
    let daysBetweenChoices = [0.5, 1.0, 7.0]


    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("How often (days)", selection: $daysBetween) {
                    ForEach(daysBetweenChoices, id: \.self) { option in
                        Text("\(option, specifier: "%.1f")").tag(option)
                    }
                }
            }
            .navigationTitle("Add new habit")
            .toolbar {
                Button("Save") {
                    let habit = HabitItem(
                        name: name,
                        lastDone: Date().addingTimeInterval(-86_400 * daysBetween),
                        daysBetweenCompletions: daysBetween
                    )
                    habitsCollection.items.append(habit)
                    habitsCollection.sort()
                    dismiss()
                }
            }
        }
    }
}


/*struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}*/
