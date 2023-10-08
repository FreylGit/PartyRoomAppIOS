
import Foundation
struct ProfileModel: Codable {
    let id: String
    let firtsName, lastName, userName: String
    let email: String?
    let phoneNumber: String?
    let details: Details
    let tags: [Tag]
}


struct Details: Codable {
    let about: String
    let imagePath: String
}


struct Tag: Codable,Identifiable {
    let id, name: String
    let important: Bool
    let isLike: Bool
}
