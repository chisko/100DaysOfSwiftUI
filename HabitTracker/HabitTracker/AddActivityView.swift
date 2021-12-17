//
//  AddActivityView.swift
//  HabitTracker
//
//  Created by Francisco Ruiz on 16/12/21.
//

import SwiftUI

struct AddActivityView: View {
    @ObservedObject var activities: Activities
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var description: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Activity Name", text: $name)
                } header: {
                    Text("Activity Name")
                }
                
                Section {
                    TextField("Activity Description", text: $description)
                } header: {
                    Text("Activity Description")
                }
            }
            .navigationTitle("Add Activity")
            .toolbar {
                Button {
                    let item = ActivityItem(name: name, description: description, completionCount: 0)
                    activities.items.append(item)
                    dismiss()
                } label: {
                    Text("Save")
                }
            }
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(activities: Activities())
    }
}
