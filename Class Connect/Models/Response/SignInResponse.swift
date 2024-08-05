import Foundation

struct SignInResponse: Codable, Equatable {
    let status: Int?
    let message: String?
    let data: SignInData?
    
    static func ==(lhs: SignInResponse, rhs: SignInResponse) -> Bool {
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
        data = try values.decodeIfPresent(SignInData.self, forKey: .data)
    }
}

struct SignInData: Codable {
    let createdAt: Int?
    let updatedAt: Int?
    let id: String?
    let firstName: String?
    let lastName: String?
    let email: String?
    let contactNumber: String?
    let dob: String?
    let token: String?

    enum CodingKeys: String, CodingKey {
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case id = "id"
        case firstName = "firstName"
        case lastName = "lastName"
        case email = "email"
        case contactNumber = "contactNumber"
        case dob = "dob"
        case token = "token"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        contactNumber = try values.decodeIfPresent(String.self, forKey: .contactNumber)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }
}
