//
//  SignInViewModel.swift
//  Class Connect
//
//  Created by user on 26/07/24.
//

import Foundation
import SwiftUI
import Combine


class UsersViewModel: ObservableObject {
    @Published var data: UsersResponse? = nil
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    @AppStorage("token") private var token: String?
    private var cancellables = Set<AnyCancellable>()
    func handleFetchUsers (code: String) {
        isLoading = true
        let parameters = ["courseCode": code]
        let headers = ["Authorization": "Bearer \(token!)"]
        NetworkService.shared.request(
            urlString: "/api/course/getUsers",
            method: .get,
            parameters: parameters,
            headers: headers,
            as: UsersResponse.self
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
