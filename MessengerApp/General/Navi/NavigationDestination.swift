//
//  NavigationDestination.swift
//  MessengerApp
//
//  Created by 정성윤 on 9/2/24.
//

import Foundation

enum NavigationDestination: Hashable {
    case chat(chatRoomId: String, myUserId: String, otherUserId: String)
    case search
}
