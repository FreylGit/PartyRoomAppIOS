// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let roomsModel = try? JSONDecoder().decode(RoomsModel.self, from: jsonData)

import Foundation

struct RoomsModelElement: Codable {
    let id, name, type: String
    let price: Int
    let isStarted: Bool
    let startDate, finishDate: String
}
