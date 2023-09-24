import Foundation
struct RoomCreateModel: Codable {
    var name, type: String
    var price: Int
    var startDate, finishDate: String
}
