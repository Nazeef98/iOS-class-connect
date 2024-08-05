
import Foundation
import SwiftUI
import Combine


class DropDetailsViewModel: ObservableObject {
    @Published var data: DropDetailsResponse? = nil
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    @AppStorage("token") private var token: String?
    private var cancellables = Set<AnyCancellable>()
    func createPublicProfile (payload: DropDetailsRequest) {
        let parameters = [
            "user": payload.user,
            "name": payload.name,
            "phone": payload.phone,
            "address": payload.address,
            "city": payload.city,
            "email": payload.email,
            "state": payload.state,
            "zip": payload.zip,
            "country": payload.country,
            "courseCode": payload.courseCode,
            "accommodation": payload.accommodation
        ] as [String : Any]
        let headers = ["Authorization": "Bearer \(token!)"]
        NetworkService.shared.request(
            urlString: "/api/user/createPublicProfile",
            method: .post,
            parameters: parameters,
            headers: headers,
            as: DropDetailsResponse.self
        ){
            result in
            self.isLoading = false
            switch result {
            case .success(let data):
                if(data.status == 200) {
                    self.data = data
                } else {
                    self.errorMessage = data.message
                }
            case .failure(let error):
                self.errorMessage = "\(error)"
            }
        }
    }
    func updatePublicProfile(payload: DropDetailsRequest) {
        let parameters = [
            "user": payload.user,
            "name": payload.name,
            "phone": payload.phone,
            "address": payload.address,
            "city": payload.city,
            "email": payload.email,
            "state": payload.state,
            "zip": payload.zip,
            "country": payload.country,
            "courseCode": payload.courseCode,
            "accommodation": payload.accommodation
        ] as [String : Any]
        let headers = ["Authorization": "Bearer \(token!)"]
        NetworkService.shared.request(
            urlString: "/api/user/updatePublicProfile",
            method: .post,
            parameters: parameters,
            headers: headers,
            as: DropDetailsResponse.self
        ){
            result in
            self.isLoading = false
            switch result {
            case .success(let data):
                print("Response --->>> \(data)")
                if(data.status == 200) {
                    self.data = data
                } else {
                    self.errorMessage = data.message
                }
            case .failure(let error):
                self.errorMessage = "\(error)"
            }
        }
    }
    func getPublicProfile(id: String) {
        isLoading = true
        let parameters = ["id": id]
        let headers = ["Authorization": "Bearer \(token!)"]
        NetworkService.shared.request(
            urlString: "/api/user/getProfile",
            method: .get,
            parameters: parameters,
            headers: headers,
            as: DropDetailsResponse.self
        ){
            result in
            self.isLoading = false
            switch result {
            case .success(let data):
                if(data.status == 200) {
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
