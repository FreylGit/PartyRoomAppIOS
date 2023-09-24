//
//  RoomDetailsModel.swift
//  PartyRoomAppIOS
//
//  Created by Андрей on 16.09.2023.
//

import Foundation
struct RoomDetailsModel: Codable {
    let name, type: String
    let price: Int
    var destinationUserID, startDate, finishDate: String

    enum CodingKeys: String, CodingKey {
        case name, type, price
        case destinationUserID = "destinationUserId"
        case startDate, finishDate
    }
}
