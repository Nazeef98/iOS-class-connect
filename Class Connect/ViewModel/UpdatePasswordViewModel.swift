//
//  ResetPasswordViewModel.swift
//  Class Connect
//
//  Created by user on 29/07/24.
//

import Foundation
import SwiftUI
import Combine

class UpdatePasswordViewModel: ObservableObject {
    @Published var data: UpdatePasswordResponse? = nil
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    func handleUpdatePassword (payload: UpdatePasswordRequest) {
        isLoading = true
        let parameters = ["otp": payload.otp, "email": payload.email, "password": payload.password]
        NetworkService.shared.request(
            urlString: "/api/auth/updatePassword",
            method: .post,
            parameters: parameters,
            as: UpdatePasswordResponse.self
        ){
            result in
            self.isLoading = false
            switch result {
            case .success(let data):
                print("POST Success: \(data)")
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
