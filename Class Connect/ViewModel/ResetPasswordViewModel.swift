//
//  ResetPasswordViewModel.swift
//  Class Connect
//
//  Created by user on 29/07/24.
//

import Foundation
import SwiftUI
import Combine

class ResetPasswordViewModel: ObservableObject {
    @Published var data: ResetPasswordResponse? = nil
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    func handleResetPassword (payload: ResetPasswordRequest) {
        isLoading = true
        let parameters = ["email": payload.email]
        NetworkService.shared.request(
            urlString: "/api/auth/resetPassword",
            method: .post,
            parameters: parameters,
            as: ResetPasswordResponse.self
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
                self.errorMessage = "\(error)"
            }
        }
    }
}
