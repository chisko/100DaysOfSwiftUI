//
//  ActivityDetailView.swift
//  HabitTracker
//
//  Created by Francisco Ruiz on 16/12/21.
//

import SwiftUI

struct ActivityDetailView: View {
    @ObservedObject var activities: Activities
    @State var selectedActivity: ActivityItem
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(selectedActivity.description)
            }
            .padding(.bottom)
            
            Text("Times you have completed this activity:")
                .font(.subheadline)
                .padding(.bottom)
            
            Text("\(selectedActivity.completionCount)")
                .font(.largeTitle.bold())
            
            Button {
                updateActivity()
            } label: {
                Text("Add 1 more")
                    .font(.headline)
            }
            .padding()
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .padding()
        .navigationTitle(selectedActivity.name)
    }
    
    func updateActivity() {
        if let index = activities.items.firstIndex(of: selectedActivity) {
            selectedActivity.completionCount += 1
            activities.items[index] = selectedActivity
        }
    }
}

struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let activity = ActivityItem(name: "Test", description: "desc 1", completionCount: 0)
        ActivityDetailView(activities: Activities(), selectedActivity: activity)
    }
}
