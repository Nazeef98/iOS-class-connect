//
//  ApiResponse.swift
//  Class Connect
//
//  Created by user on 24/07/24.
//

struct ApiResponse: Codable {
    let status: Int
    let message: String?
    let data: [String: String]?
}
