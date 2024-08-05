//
//  SignUp.swift
//  Class Connect
//
//  Created by user on 24/07/24.
//

import Foundation

struct SignUpRequest: Codable {
    var email: String
    var firstName: String
    var lastName: String
    var contactNumber: String
    var password: String
    var confirmPassword: String
}
