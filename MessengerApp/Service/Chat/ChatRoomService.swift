//
//  ChatRoomService.swift
//  MessengerApp
//
//  Created by 정성윤 on 9/2/24.
//

import Foundation
import Combine

protocol ChatRoomServiceType {
    func createChatRoomIfNeeded(myUserId: String, otherUserId: String, otherUserName: String) -> AnyPublisher<ChatRoom, ServiceError>
    func loadChatRooms(myUserId: String) -> AnyPublisher<[ChatRoom], ServiceError>
    func updateChatRoomLastMessage(chatRoomId: String, myUserId: String, myUserName: String, otherUserId: String, lastMessage: String) -> AnyPublisher<Void, ServiceError>
}

class ChatRoomService: ChatRoomServiceType {
    
    private var dbRepository: ChatRoomDBRepository
    
    init(dbRepository: ChatRoomDBRepository) {
        self.dbRepository = dbRepository
    }
    
    func createChatRoomIfNeeded(myUserId: String, otherUserId: String, otherUserName: String) -> AnyPublisher<ChatRoom, ServiceError> {
        dbRepository.getChatRoom(myUserId: myUserId, otherUserId: otherUserId)
            .mapError { ServiceError.error($0) }
            .flatMap { object in
                if let object {
                    return Just(object.toModel()).setFailureType(to: ServiceError.self).eraseToAnyPublisher()
                } else {
                    let newChatRoom: ChatRoom = .init(chatRoomId: UUID().uuidString, otherUserName: otherUserName, otherUserId: otherUserId)
                    return self.addChatRoom(newChatRoom, to: myUserId)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func addChatRoom(_ chatRoom: ChatRoom, to myUserId: String) -> AnyPublisher<ChatRoom, ServiceError> {
        dbRepository.addChatRoom(chatRoom.toObject(), myUserId: myUserId)
            .map { chatRoom }
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }
    
    func loadChatRooms(myUserId: String) -> AnyPublisher<[ChatRoom], ServiceError> {
        dbRepository.loadChatRooms(myUserId: myUserId)
            .map { $0.map { $0.toModel()} }
            .mapError { ServiceError.error($0) }
            .eraseToAnyPublisher()
    }
    
    func updateChatRoomLastMessage(chatRoomId: String, myUserId: String, myUserName: String, otherUserId: String, lastMessage: String) -> AnyPublisher<Void, ServiceError> {
        return dbRepository.updateChatRoomLastMessage(chatRoomId: chatRoomId, myUserId: myUserId, myUserName: myUserName, otherUserId: otherUserId, lastMessage: lastMessage)
            .mapError { ServiceError.error($0) }
            .eraseToAnyPublisher()
    }
}

class StubChatRoomService: ChatRoomServiceType {
    
    func createChatRoomIfNeeded(myUserId: String, otherUserId: String, otherUserName: String) -> AnyPublisher<ChatRoom, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func loadChatRooms(myUserId: String) -> AnyPublisher<[ChatRoom], ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func updateChatRoomLastMessage(chatRoomId: String, myUserId: String, myUserName: String, otherUserId: String, lastMessage: String) -> AnyPublisher<Void, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
}
