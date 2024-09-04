//
//  HomeViewModel.swift
//  MessengerApp
//
//  Created by 정성윤 on 8/10/24.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject {
    
    enum Action {
        case load
        case requestContacts
        case presentMyProfileView
        case presentOtherProfileView(String)
        case goToChat(User)
    }
    
    
    @Published var myUser : User?
    @Published var users : [User] = []
    @Published var phase: Phase = .notRequested
    @Published var modalDestination: HomeModalDestination?
    
    var userId: String
    private var container : DIContainer
    private var navigationRouter: NavigationRouter
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer, userId: String, navigationRouter: NavigationRouter) {
        self.container = container
        self.userId = userId
        self.navigationRouter = navigationRouter
    }
    
    func send(action: Action) {
        switch action {
        case .load:
            phase = .loading
            container.service.userService.getUser(userId: userId)
                .handleEvents(receiveOutput: { [weak self] user in
                    self?.myUser = user
                })
                .flatMap { user in
                    self.container.service.userService.loadUser(id: user.id)
                }
                .sink { [weak self] completion in
                    if case .failure = completion {
                        self?.phase = .fail
                    }
                } receiveValue: { [weak self] users in
                    self?.phase = .success
                    self?.users = users
                }.store(in: &subscriptions )
        case .requestContacts:
            container.service.contactService.fetchContacts()
                .flatMap { users in
                    self.container.service.userService.addUserAfterContact(users: users)
                }.flatMap({ _ in
                    self.container.service.userService.loadUser(id: self.userId)
                })
                .sink { [weak self] completion in
                    if case .failure = completion {
                        self?.phase = .fail
                    }
                } receiveValue: { [weak self] users in
                    self?.phase = .success
                    self?.users = users
                }.store(in: &subscriptions)

        case .presentMyProfileView:
            self.modalDestination = .myProfile
        case let .presentOtherProfileView(userId):
            self.modalDestination = .otherProfile(userId)
        case let .goToChat(otherUser):
            container.service.chatRoomSerice.createChatRoomIfNeeded(myUserId: userId, otherUserId: otherUser.id, otherUserName: otherUser.name)
                .sink { completion in
                    
                } receiveValue: { [weak self] chatRoom in
                    if let myUserId = self?.userId{
                        self?.navigationRouter.push(to: .chat(chatRoomId: chatRoom.chatRoomId, myUserId: myUserId, otherUserId: otherUser.id))
                    }
                }.store(in: &subscriptions)
            
        }
    }
}
