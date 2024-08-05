//
//  UserListView.swift
//  Class Connect
//
//  Created by user on 22/07/24.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel = UsersViewModel()
    func onLogout() {
        
    }
    func gotoAbout() {
        
    }
    var body: some View {
        VStack {
            ListHeader(greetingsTo: "Ahsan Ahmad", onGotoAbout: gotoAbout, onLogout: onLogout)
            List(viewModel.data?.data ?? []) { user in
                HStack {
                    Text(user.name!)
                    Spacer()
                    Text(user.country!)
                }
                .padding(.vertical)
            }
            .listStyle(PlainListStyle())
            .refreshable {
                viewModel.handleFetchUsers(code: "ACPT")
            }
            Button(action:{
                
            }){
                Text("Add your details")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(5.0)
            }
            .padding(.horizontal, 20)
        }
        .onAppear{
            viewModel.handleFetchUsers(code: "ACPT")
        }
    }
}

#Preview {
    UserListView()
}
