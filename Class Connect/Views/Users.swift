//
//  Users.swift
//  Class Connect
//
//  Created by user on 22/07/24.
//

import SwiftUI

struct Users: View {
    @StateObject private var viewModel = UsersViewModel()
    @AppStorage("courseCode") private var cCode: String?
    @AppStorage("userId") private var userId: String?
    @State private var navigateToUserDetails = false
    var onUserSelect: () -> Void?
    var body: some View {
        NavigationStack{
            List(viewModel.data?.data?.enumerated().map { $0 } ?? [], id: \.element.id) { index, user in
                NavigationLink {
                    UserDetail(profile: user)
                        .navigationTitle("Detail")
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                    ListRow(index: index, user: user)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Students")
            .refreshable {
                viewModel.handleFetchUsers(code: cCode ?? "")
            }
            .onAppear{
                viewModel.handleFetchUsers(code: cCode ?? "")
            }
            NavigationLink(
                destination: DropDetailsView(),
                isActive: $navigateToUserDetails
            ) {
                EmptyView()
            }
            Button(action:{
                navigateToUserDetails = true
            }){
                Text("Add/Edit your details")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(5.0)
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    Users(onUserSelect: {
        print("User Selected");
    })
}
