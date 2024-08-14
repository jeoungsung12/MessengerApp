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
    }
    
    
    @Published var myUser : User?
    @Published var users : [User] = []
    @Published var phase: Phase = .notRequested
    @Published var modalDestination: HomeModalDestination?
    
    var userId: String
    private var container : DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer, userId: String) {
        self.container = container
        self.userId = userId
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
        }
    }
}
