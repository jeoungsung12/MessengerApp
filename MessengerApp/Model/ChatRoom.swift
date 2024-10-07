//
//  ChatRoom.swift
//  MessengerApp
//
//  Created by 정성윤 on 9/2/24.
//

import Foundation

struct ChatRoom: Hashable {
    var chatRoomId: String
    var lastMessage: String?
    var otherUserName: String
    var otherUserId: String
}

extension ChatRoom {
    func toObject() -> ChatRoomObject {
        .init(chatRoomId: chatRoomId, lastMessage: lastMessage, otherUserName: otherUserName, otherUserId: otherUserId)
    }
}
