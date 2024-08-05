//
//  SignInViewModel.swift
//  Class Connect
//
//  Created by user on 26/07/24.
//

import Foundation
import SwiftUI
import Combine


class SignInViewModel: ObservableObject {
    @Published var data: SignInResponse? = nil
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    private var cancellables = Set<AnyCancellable>()
    func handleSignIn (payload: LoginRequest) {
        self.errorMessage = nil
        isLoading = true
        let parameters = ["email": payload.email, "password": payload.password]
        NetworkService.shared.request(
            urlString: "/api/auth/signIn",
            method: .post,
            parameters: parameters,
            as: SignInResponse.self
        ){
            result in
            self.isLoading = false
            switch result {
            case .success(let data):
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
