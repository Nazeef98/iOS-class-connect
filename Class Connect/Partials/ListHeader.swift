//
//  ListHeader.swift
//  Class Connect
//
//  Created by user on 23/07/24.
//

import SwiftUI

struct ListHeader: View {
    var greetingsTo: String
    var onGotoAbout: () -> Void
    var onLogout: () -> Void
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .padding(.leading)
            Text("Greetings " + greetingsTo)
                .font(.title3)
                .fontWeight(.medium)
                .padding(.leading)
            Spacer()
            Menu {
                Button(action: {
                    // Action for first option
                }) {
                    Text("Change Password")
                }
                Button(action: {
                    // Action for second option
                    onGotoAbout()
                }) {
                    Text("About")
                }
                Button(action: {
                    // Action for third option
                    onLogout()
                }) {
                    Text("Logout")
                }
            } label: {
                Image(systemName: "ellipsis")
                    .frame(height: 50.0)
                    .padding(.horizontal, 20)
            }
        }
        .padding(.vertical, 10)
        .background(Color.blue.opacity(0.2))
    }
}

#Preview {
    ListHeader(
        greetingsTo: "Ahsan Ahmad",
        onGotoAbout: {
            print("About")
        },
        onLogout: {
            print("Logging Out")
        }
    )
}
