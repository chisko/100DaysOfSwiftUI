//
//  ContentView.swift
//  Friendface
//
//  Created by Francisco Ruiz on 22/12/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)], predicate: nil) var users: FetchedResults<CachedUser>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)], predicate: nil) var friends: FetchedResults<CachedFriend>
    //@StateObject var users = Users()
    //@State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users) { user in
                    NavigationLink {
                        DetailView(user: user)
                    } label: {
                        HStack {
                            Text(user.wrappedName)
                                .font(.headline)
                            
                            Spacer()
                            
                            Text(user.isActive ? "Active" : "Not active")
                                .font(.subheadline.bold())
                                .foregroundColor(user.isActive ? .green : .red)
                        }
                    }
                }
            }
            .navigationTitle("Friendface")
            .toolbar {
                Button {
                    deleteAll()
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
        .task {
            await loadUsers()
        }
    }
    
    func deleteAll() {
        for user in users {
            moc.delete(user)
        }
        
        for friend in friends {
            moc.delete(friend)
        }
        
        try? moc.save()
    }
    
    func loadUsers() async {
        guard users.isEmpty else {
            print("Ya hay datos en CoreData")
            return
        }
        
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        do {
            print("Load from json url")
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let decodedUsers = try decoder.decode([User].self, from: data)
            /*
            DispatchQueue.main.async {
                users = decodedUsers
            }
            */
            
            await MainActor.run {
                updateCache(with: decodedUsers)
            }
        } catch {
            print("Error loading users")
        }
    }
    
    func updateCache(with downloadedUsers: [User]) {
        for user in downloadedUsers {
            let newUser = CachedUser(context: moc)
            
            newUser.id = user.id
            newUser.isActive = user.isActive
            newUser.name = user.name
            newUser.age = Int16(user.age)
            newUser.company = user.company
            newUser.email = user.email
            newUser.address = user.address
            newUser.about = user.about
            newUser.registered = user.registered
            newUser.tags = user.tags.joined(separator: ",")
            
            print("USER:")
            print("\(user.id) - \(user.name)")
            print("FRIENDS:")
            for friend in user.friends {
                let newFriend = CachedFriend(context: moc)
                newFriend.id = friend.id
                newFriend.name = friend.name
                newUser.addToFriends(newFriend)
                print("\(friend.id) - \(friend.name)")
            }
            
            do {
                try moc.save()
            } catch {
                print("ERROR TRYING TO SAVE!")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
