import Foundation

struct CoursesResponse: Codable, Equatable {
    let status: Int?
    let message: String?
    let data: [Course]?

    static func ==(lhs: CoursesResponse, rhs: CoursesResponse) -> Bool {
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
        data = try values.decodeIfPresent([Course].self, forKey: .data)
    }
}

struct Course: Codable, Identifiable {
    let createdAt: Int?
    let updatedAt: Int?
    let id: String?
    let title: String?
    let description: String?

    enum CodingKeys: String, CodingKey {
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case id = "id"
        case title = "title"
        case description = "description"
    }
    init(createdAt: Int?, updatedAt: Int?, id: String?, title: String?, description: String?) {
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.id = id
        self.title = title
        self.description = description
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }
}
