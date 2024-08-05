import Foundation

struct UsersResponse: Codable, Equatable {
    let status: Int?
    let message: String?
    let data: [Profile]?

    static func ==(lhs: UsersResponse, rhs: UsersResponse) -> Bool {
        return lhs.status == rhs.status && lhs.message == rhs.message
    }

    enum CodingKeys: String, CodingKey {
        case status
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([Profile].self, forKey: .data)
    }
}

struct Profile: Codable, Identifiable {
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
        case createdAt
        case updatedAt
        case id
        case name
        case phone
        case email
        case address
        case city
        case state
        case zip
        case country
        case accommodation
        case courseCode
        case user
    }
    
    init(createdAt: Int?, updatedAt: Int?, id: String?, name: String?, phone: String?, email: String?, address: String?, city: String?, state: String?, zip: String?, country: String?, accommodation: Bool?, courseCode: String?, user: String?) {
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.id = id
        self.name = name
        self.phone = phone
        self.email = email
        self.address = address
        self.city = city
        self.state = state
        self.zip = zip
        self.country = country
        self.accommodation = accommodation
        self.courseCode = courseCode
        self.user = user
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
