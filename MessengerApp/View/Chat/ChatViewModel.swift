//
//  ChatViewModel.swift
//  MessengerApp
//
//  Created by 정성윤 on 9/4/24.
//

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    
    enum Action {
        
    }
    
    @Published var chatDataList: [ChatData] = []
    @Published var myUser: User?
    @Published var otherUser: User?
    @Published var message: String = ""
    
    private let chatRoomId: String
    private let myUserId: String
    private let otherUserId: String
    
    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(chatRoomId: String, myUserId: String, otherUserId: String, container: DIContainer) {
        self.chatRoomId = chatRoomId
        self.myUserId = myUserId
        self.otherUserId = otherUserId
        self.container = container
        
        updateChatDataList(.init(chatId: "chat1_id", userId: "user1_id", message: "안녕하세요", date: Date()))
        updateChatDataList(.init(chatId: "chat2_id", userId: "user2_id", message: "감사해요", date: Date()))
        updateChatDataList(.init(chatId: "chat3_id", userId: "user1_id", message: "잘있어요", date: Date()))
    }
    
    func updateChatDataList(_ chat: Chat) {
        let key = chat.date.toChatDataKey
        
        if let index = chatDataList.firstIndex(where: { $0.dateStr == key }) {
            chatDataList[index].chats.append(chat)
        } else {
            let newChatData: ChatData = .init(dateStr: key, chats: [chat])
            chatDataList.append(newChatData)
        }
    }
    
    func getDirection(id: String) -> ChatItemDirection {
        myUserId == id ? .right : .left
    }
    
    func send(action: Action) {
        
    }
}
