//
//  Message.swift
//  MessengerApp
//
//  Created by 정성윤 on 9/4/24.
//

import Foundation

struct Chat: Hashable, Identifiable {
    var chatId: String
    var userId: String
    var message: String?
    var photoURL: String?
    var date: Date
    var id: String { chatId }
}
