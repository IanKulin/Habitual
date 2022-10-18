//
//  ContentView.swift
//  Habitual
//
//  Created by Ian Bailey on 16/10/2022.
//

import SwiftUI


struct HabitView: View {

    @State var habitItem: HabitItem
    @StateObject var habitsCollection: Habits
    @State var refresh: Bool

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(habitItem.name)
                    .font(.headline)
                Text(habitItem.lastDone.formatted(date: .abbreviated, time: .omitted))
            }
            Spacer()
            Text(" \(habitItem.timesDone)  ")
                .font(.largeTitle)
            Button {
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
            .buttonStyle(.borderless)
        }
    }
}


struct ContentView: View {

    @StateObject var habitsCollection = Habits()
    @State private var showingAddHabit = false

    @State private var refresh = false
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        NavigationView {
            List {
                ForEach(habitsCollection.items) { habitItem in
                    HabitView(habitItem: habitItem, habitsCollection: habitsCollection, refresh: refresh)
                }
                .onDelete(perform: removeHabit)
            }
            .navigationTitle("Habitual")
            .toolbar {
                Button {
                    showingAddHabit = true
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 25))
                        .padding(.horizontal)
                }
            }
            .refreshable {
                refresh.toggle()
            }
        }
        .sheet(isPresented: $showingAddHabit) {
            AddView(habitsCollection: habitsCollection)
        }
        .onAppear {
            refresh.toggle()
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                refresh.toggle()
            }
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
