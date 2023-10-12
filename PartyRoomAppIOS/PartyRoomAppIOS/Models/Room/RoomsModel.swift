import Foundation

struct RoomsModelElement: Codable {
    let id, name, type: String
    let price: Int
    let quantityParticipant:Int
    let isStarted: Bool
    let startDate, finishDate: String
    
}
