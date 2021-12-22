//
//  DetailView.swift
//  Friendface
//
//  Created by Francisco Ruiz on 22/12/21.
//

import SwiftUI

struct DetailView: View {
    //let user: User
    let user: CachedUser
    
    var body: some View {
        List {
            Section {
                Text(user.wrappedAbout)
                    .padding(.vertical)
            } header: {
                Text("About")
            }

            Section {
                Text("Address: \(user.wrappedAddress)")
                Text("Company: \(user.wrappedCompany)")
            } header: {
                Text("Contact details")
            }

            Section {
                ForEach(user.friendsArray) { friend in
                    Text(friend.wrappedName)
                }
            } header: {
                Text("Friends")
            }
            
            Section {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(user.wrappedTags, id:\.self) { tag in
                            Text(tag)
                                .padding(.horizontal)
                                .padding(.vertical, 4)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                        }
                    }
                }
            } header: {
                Text("Tags")
            }
        }
        .listStyle(.grouped)
        .navigationTitle(user.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
    }
}


