//
//  ContentView.swift
//  HabitTracker
//
//  Created by Francisco Ruiz on 16/12/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var activities = Activities()
    
    @State private var showAddActivity = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.items) { activity in
                    NavigationLink {
                        ActivityDetailView(activities: activities, selectedActivity: activity)
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(activity.name)
                                    .font(.headline)
                                
                                Text(activity.description)
                                    .font(.caption)
                            }
                            
                            Spacer()
                            
                            Text("\(activity.completionCount)")
                                .foregroundColor(.white)
                                .font(.headline.weight(.black))
                                .padding(5)
                                .frame(minWidth: 50)
                                .background(color(for: activity))
                                .clipShape(Capsule())
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                Button {
                    showAddActivity.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showAddActivity) {
            AddActivityView(activities: activities)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
    
    func color(for activity: ActivityItem) -> Color {
        if activity.completionCount < 3 {
            return .red
        } else if activity.completionCount < 10 {
            return .orange
        } else if activity.completionCount < 20 {
            return .green
        } else if activity.completionCount < 50 {
            return .blue
        } else {
            return .indigo
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
