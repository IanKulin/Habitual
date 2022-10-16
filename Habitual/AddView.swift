//
//  AddView.swift
//  Habitual
//
//  Created by Ian Bailey on 16/10/2022.
//

import SwiftUI


struct AddView: View {
    @ObservedObject var habits: Habits
    @Environment(\.dismiss) var dismiss

    @State private var name = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
            }
            .navigationTitle("Add new habit")
            .toolbar {
                Button("Save") {
                    let habit = HabitItem(name: name, lastDone: Date())
                    habits.items.append(habit)
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
