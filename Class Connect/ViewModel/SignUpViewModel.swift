//
//  SignInViewModel.swift
//  Class Connect
//
//  Created by user on 26/07/24.
//

import Foundation
import SwiftUI
import Combine


class SignUpViewModel: ObservableObject {
    @Published var data: SignupResponse? = nil
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    private var cancellables = Set<AnyCancellable>()
    func handleSignUp (payload: SignUpRequest) {
        self.errorMessage = nil
        let parameters = [
            "email": payload.email.lowercased(),
            "firstName": payload.firstName,
            "lastName": payload.lastName,
            "contactNumber": payload.contactNumber,
            "password": payload.password
        ]
        NetworkService.shared.request(
            urlString: "/api/auth/signUp",
            method: .post,
            parameters: parameters,
            as: SignupResponse.self
        ){
            result in
            self.isLoading = false
            switch result {
            case .success(let data):
                print("Response --->>> \(data)")
                if data.status == 200 {
                    self.data = data
                } else {
                    self.errorMessage = data.message
                }
            case .failure(let error):
                print("POST Error: \(error)")
                self.errorMessage = "\(error)"
            }
        }
    }
}
