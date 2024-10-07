//
//  ChatRoomObject.swift
//  MessengerApp
//
//  Created by 정성윤 on 9/2/24.
//

import Foundation

struct ChatRoomObject: Codable {
    var chatRoomId: String
    var lastMessage: String?
    var otherUserName: String
    var otherUserId: String
}

extension ChatRoomObject {
    func toModel() -> ChatRoom {
        .init(chatRoomId: chatRoomId, lastMessage: lastMessage, otherUserName: otherUserName, otherUserId: otherUserId)
    }
}
