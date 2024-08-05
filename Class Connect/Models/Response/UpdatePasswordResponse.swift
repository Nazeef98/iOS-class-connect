import Foundation

struct UpdatePasswordResponse: Codable, Equatable {
    let status: Int?
    let message: String?
    let data: [String: Any]? // Changed from SignInData? to String?

    static func ==(lhs: UpdatePasswordResponse, rhs: UpdatePasswordResponse) -> Bool {
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
            
            if let dataString = try? values.decode(String.self, forKey: .data),
               let data = dataString.data(using: .utf8) {
                self.data = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } else {
                self.data = nil
            }
        }
    func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(status, forKey: .status)
            try container.encode(message, forKey: .message)

            if let data = self.data,
               let dataString = try? JSONSerialization.data(withJSONObject: data, options: []),
               let jsonString = String(data: dataString, encoding: .utf8) {
                try container.encode(jsonString, forKey: .data)
            }
        }
}
