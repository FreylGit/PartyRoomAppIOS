import Foundation

struct AccountRegistrationModel: Codable {
    let firstName, lastName, userName, email: String
    let phoneNumber, password: String
}
