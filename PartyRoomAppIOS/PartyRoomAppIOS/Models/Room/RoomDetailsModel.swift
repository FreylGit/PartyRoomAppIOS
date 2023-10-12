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
    let quantityParticipant : Int
    let isAuthor: Bool
    let isStarted: Bool
    let link:String?
    var destinationUserID, startDate, finishDate: String
    var destinationUserName: String?

    enum CodingKeys: String, CodingKey {
        case name, type, price,quantityParticipant
        case destinationUserID = "destinationUserId"
        case startDate, finishDate
        case isAuthor
        case isStarted
        case link
        case destinationUserName
    }
}
