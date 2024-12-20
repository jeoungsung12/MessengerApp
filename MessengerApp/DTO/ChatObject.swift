//
//  ChatObject.swift
//  MessengerApp
//
//  Created by 정성윤 on 9/4/24.
//

import Foundation

struct ChatObject: Codable {
    var chatId: String
    var userId: String
    var message: String?
    var photoURL: String?
    var date: TimeInterval
}

extension ChatObject {
    func toModel() -> Chat {
        .init(chatId: chatId, userId: userId, message: message, photoURL: photoURL, date: Date(timeIntervalSince1970: date))
    }
}
