import Foundation

struct DropDetailsResponse: Codable {
    let status: Int?
    let message: String?
    let data: DropDetailsData?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(DropDetailsData.self, forKey: .data)
    }
}

struct DropDetailsData: Codable {
    let createdAt: Int?
    let updatedAt: Int?
    let id: String?
    let name: String?
    let phone: String?
    let email: String?
    let address: String?
    let city: String?
    let state: String?
    let zip: String?
    let country: String?
    let accommodation: Bool?
    let courseCode: String?
    let user: String?

    enum CodingKeys: String, CodingKey {
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case id = "id"
        case name = "name"
        case phone = "phone"
        case email = "email"
        case address = "address"
        case city = "city"
        case state = "state"
        case zip = "zip"
        case country = "country"
        case accommodation = "accommodation"
        case courseCode = "courseCode"
        case user = "user"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        zip = try values.decodeIfPresent(String.self, forKey: .zip)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        accommodation = try values.decodeIfPresent(Bool.self, forKey: .accommodation)
        courseCode = try values.decodeIfPresent(String.self, forKey: .courseCode)
        user = try values.decodeIfPresent(String.self, forKey: .user)
    }
}
