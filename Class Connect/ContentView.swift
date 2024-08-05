//
//  ContentView.swift
//  Class Connect
//
//  Created by user on 19/07/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var isLoggedIn: Bool = false
    func onLogin () {
        isLoggedIn = true
    }
    func onLogout () {
        isLoggedIn = false;
    }
    
    var body: some View {
        
        VStack {
            if isLoggedIn {
                CourseListView(onLogout: onLogout)
            } else {
                LoginView(onLogin: onLogin)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
