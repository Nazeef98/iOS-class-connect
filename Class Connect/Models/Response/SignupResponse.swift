
import Foundation

struct SignupResponse : Codable {
    let status : Int?
    let message : String?
    let data : SignupData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(SignupData.self, forKey: .data)
    }

}

struct SignupData : Codable {
	let createdAt : Int?
	let updatedAt : Int?
	let id : String?
	let firstName : String?
	let lastName : String?
	let email : String?
	let password : String?
	let contactNumber : String?
	let dob : String?
	let token : String?

	enum CodingKeys: String, CodingKey {

		case createdAt = "createdAt"
		case updatedAt = "updatedAt"
		case id = "id"
		case firstName = "firstName"
		case lastName = "lastName"
		case email = "email"
		case password = "password"
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
		password = try values.decodeIfPresent(String.self, forKey: .password)
		contactNumber = try values.decodeIfPresent(String.self, forKey: .contactNumber)
		dob = try values.decodeIfPresent(String.self, forKey: .dob)
		token = try values.decodeIfPresent(String.self, forKey: .token)
	}
}
