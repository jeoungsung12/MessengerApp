//
//  ChatData.swift
//  MessengerApp
//
//  Created by 정성윤 on 9/4/24.
//

import Foundation

struct ChatData: Hashable, Identifiable {
    var dateStr: String
    var chats: [Chat]
    var id: String { dateStr }
}
