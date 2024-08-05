//
//  ResetPasswordResponse.swift
//  Class Connect
//
//  Created by user on 29/07/24.
//

import Foundation
struct ResetPasswordResponse: Codable, Equatable {
    let status: Int?
        let message: String?
        let data: String? // Changed from SignInData? to String?

    static func ==(lhs: ResetPasswordResponse, rhs: ResetPasswordResponse) -> Bool {
            return lhs.status == rhs.status && lhs.message == rhs.message
        }

        enum CodingKeys: String, CodingKey {
            case status = "status"
            case message = "message"
            case data = "data"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            status = try values.decodeIfPresent(Int.self, forKey: .status)
            message = try values.decodeIfPresent(String.self, forKey: .message)
            data = try values.decodeIfPresent(String.self, forKey: .data)
        }
}
