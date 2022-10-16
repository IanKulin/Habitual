//
//  ContentView.swift
//  Habitual
//
//  Created by Ian Bailey on 16/10/2022.
//

import SwiftUI


struct ContentView: View {

    @StateObject var habitsCollection = Habits()
    @State private var showingAddHabit = false

    var body: some View {
        NavigationView {
            List {
                ForEach(habitsCollection.items) { habitItem in
                    habitView(habitItem: habitItem, habitsCollection: habitsCollection)
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
            AddView(habitsCollection: habitsCollection)
        }
    }


    func habitView(habitItem: HabitItem, habitsCollection: Habits) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(habitItem.name)
                    .font(.headline)
                Text(habitItem.lastDone.formatted(date: .abbreviated, time: .omitted))
            }
            // some text for how many times done
            Text(" (\(habitItem.timesDone))")
                .font(.largeTitle)
            // a button to say I've just done it now
            Spacer()
            Button {
                // this is where I'd like to mark this habit as done
                if !habitsCollection.markAsDone(habit: habitItem) {
                    print("Unexpected error - habit not found in collection:\(habitItem.name)")
                }
            } label: {
                if habitItem.due {
                    Image(systemName: "rectangle")
                        .font(.system(size: 40))
                } else {
                    Image(systemName: "checkmark.rectangle")
                        .font(.system(size: 40))
                }

            }
            .buttonStyle(.bordered)
        }
    }


    func removeHabit(at offsets: IndexSet) {
        habitsCollection.items.remove(atOffsets: offsets)
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
