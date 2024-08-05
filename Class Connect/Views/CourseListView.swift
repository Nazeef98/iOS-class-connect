//
//  CourseListView.swift
//  Class Connect
//
//  Created by user on 21/07/24.
//

import SwiftUI

struct CourseListView: View {
    @AppStorage("userName") private var userName: String?
    @StateObject private var viewModel = CoursesViewModel()
    @State private var showPopup = false
    @State private var selectedCourse: Course? = nil
    @State private var isUsersViewActive: Bool = false
    @State private var isAboutActive: Bool = false
    @State private var isUserDetailViewActive: Bool = false
    @State private var userSelected: Bool = false
    var onLogout: () -> Void
    func onListItemTap (c: Course) {
        self.selectedCourse = c
        self.showPopup = true
    }
    func onCourseSelect () {
        isUsersViewActive = true
        self.showPopup = false
        self.selectedCourse = nil
    }
    func onUserSelected () {
        
    }
    func fetchCoursesList() {
        viewModel.handleFetchCourses()
    }
    func gotoAbout() {
        isAboutActive = true
    }
    var body: some View {
        NavigationStack{
            ZStack{
                if showPopup {
                    CoursePopup(course: selectedCourse, showPopup: $showPopup, onCodeVerification: onCourseSelect)
                        .frame(width: 350, height: 450)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .transition(.scale)
                        .zIndex(2)
                }
                VStack {
                    ListHeader(
                        greetingsTo: userName ?? "",
                        onGotoAbout: gotoAbout,
                        onLogout: onLogout
                    )
                    List(viewModel.data?.data ?? []) { course in
                        CourseListRow(onListItemTap: onListItemTap, data: course)
                    }
                    .listStyle(PlainListStyle())
                    .navigationDestination(isPresented: $isUsersViewActive){
                        Users(onUserSelect: onUserSelected)
                    }
                    .navigationDestination(isPresented: $isAboutActive) {
                        AboutView()
                    }
                    .refreshable {
                        fetchCoursesList()
                    }
                }
            }
        }
        .onAppear{
            viewModel.handleFetchCourses()
        }
    }
}

#Preview {
    CourseListView(onLogout: {
        print("Logging Out")
    })
}
