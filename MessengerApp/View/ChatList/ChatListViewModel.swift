//
//  ChatListViewModel.swift
//  MessengerApp
//
//  Created by 정성윤 on 9/2/24.
//

import Foundation
import Combine

class ChatListViewModel: ObservableObject {
    
    enum Action {
        case load
    }
    
    @Published var chatRooms: [ChatRoom] = []
    
    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()
    let userId: String
    
    init(container: DIContainer, userId: String) {
        self.container = container
        self.userId = userId
    }
    
    func send(action: Action) {
        switch action {
        case .load:
            container.service.chatRoomSerice.loadChatRooms(myUserId: userId)
                .sink { completion in
                    
                } receiveValue: { [weak self] chatRooms in
                    self?.chatRooms = chatRooms
                }.store(in: &subscriptions)

        }
    }
}
