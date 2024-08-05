//
//  SignInViewModel.swift
//  Class Connect
//
//  Created by user on 26/07/24.
//

import Foundation
import SwiftUI
import Combine


class VerifyCourseViewModel: ObservableObject {
    @Published var data: VerifyCourseResponse? = nil
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    @AppStorage("token") private var token: String?
    private var cancellables = Set<AnyCancellable>()
    func handleVerifyCourse (payload: VerifyCourseRequest) {
        isLoading = true
        errorMessage = nil
        let parameters = ["id": payload.id, "code": payload.code]
        let headers = ["Authorization": "Bearer \(token!)"]
        NetworkService.shared.request(
            urlString: "/api/course/verifyCourse",
            method: .post,
            parameters: parameters,
            headers: headers,
            as: VerifyCourseResponse.self
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
                self.errorMessage = "\(error)"
            }
        }
    }
}
