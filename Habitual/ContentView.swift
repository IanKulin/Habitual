//
//  ContentView.swift
//  Habitual
//
//  Created by Ian Bailey on 16/10/2022.
//

import SwiftUI


struct ContentView: View {

    @StateObject var habits = Habits()
    @State private var showingAddHabit = false

    var body: some View {
        NavigationView {
            List {
                ForEach(habits.items) { habit in
                    habitView(habit: habit)
                }
                .onDelete(perform: removeHabit)
            }
            .navigationTitle("Habitual")
            .toolbar {
                Button {
                    showingAddHabit = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddHabit) {
            AddView(habits: habits)
        }
    }


    func habitView(habit: HabitItem) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(habit.name)
                    .font(.headline)
                Text(habit.lastDone.formatted(date: .abbreviated, time: .omitted))
            }
            // some text for how many times done
            Text("     [\(habit.timesDone)]")
                .font(.largeTitle)
            // a button to say I've just done it now
            Spacer()
            Button {
                // this is where I'd like to mark this habit as done
                // habit.justDone()
            } label: {
                Image(systemName: "checkmark")
                    .font(.system(size: 40))
            }
        }
    }


    func removeHabit(at offsets: IndexSet) {
        habits.items.remove(atOffsets: offsets)
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
