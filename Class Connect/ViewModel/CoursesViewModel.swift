//
//  SignInViewModel.swift
//  Class Connect
//
//  Created by user on 26/07/24.
//

import Foundation
import SwiftUI
import Combine


class CoursesViewModel: ObservableObject {
    @Published var data: CoursesResponse? = nil
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    @AppStorage("token") private var token: String?
    private var cancellables = Set<AnyCancellable>()
    func handleFetchCourses () {
        isLoading = true
        let headers = ["Authorization": "Bearer \(token!)"]
        NetworkService.shared.request(
            urlString: "/api/course/list",
            method: .get,
            headers: headers,
            as: CoursesResponse.self
        ){
            result in
            self.isLoading = false
            switch result {
            case .success(let data):
                print("POST Success: \(data)")
                self.data = data
            case .failure(let error):
                print("POST Error: \(error)")
                self.errorMessage = "\(error)"
            }
        }
    }
}
