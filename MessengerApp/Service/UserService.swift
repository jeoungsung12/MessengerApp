//
//  UserService.swift
//  MessengerApp
//
//  Created by 정성윤 on 8/10/24.
//

import Foundation
import Combine

protocol UserServiceType {
    func addUser(_ user : User) -> AnyPublisher<User, ServiceError>
    func addUserAfterContact(users: [User]) -> AnyPublisher<Void, ServiceError>
    func getUser(userId: String) -> AnyPublisher<User, ServiceError>
    func getUser(userId: String) async throws -> User
    func updateDescription(userId: String, value: String) async throws
    func updateProfileURL(userId: String, urlString: String) async throws
    func updateFCMToken(userId: String, fcmToken: String) -> AnyPublisher<Void, ServiceError>
    func loadUser(id: String) -> AnyPublisher<[User], ServiceError>
    func filterUsers(with queryString : String, userId: String) -> AnyPublisher<[User], ServiceError>
}

class UserService : UserServiceType {
    private var dbRepository: UserDBRepositoryType
    
    init(dbRepository: UserDBRepositoryType) {
        self.dbRepository = dbRepository
    }
    
    func addUser(_ user: User) -> AnyPublisher<User, ServiceError> {
        dbRepository.addUser(user.toObject())
            .map { user }
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }
    
    func getUser(userId: String) -> AnyPublisher<User, ServiceError> {
        dbRepository.getUser(userId: userId)
            .map { $0.toModel() }
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }
    
    func getUser(userId: String) async throws -> User {
        let userObject = try await dbRepository.getUser(userId: userId)
        return userObject.toModel()
    }
    
    func updateDescription(userId: String, value: String) async throws {
        try await dbRepository.updateUser(userId: userId, key: "description", value: value)
    }
    
    func updateProfileURL(userId: String, urlString: String) async throws {
        try await dbRepository.updateUser(userId: userId, key: "profileURL", value: urlString)
    }
    
    func updateFCMToken(userId: String, fcmToken: String) -> AnyPublisher<Void, ServiceError> {
        dbRepository.updateUser(id: userId, key: "fcmToken", value: fcmToken)
            .mapError { ServiceError.error($0) }
            .eraseToAnyPublisher()
    }
    
    func loadUser(id: String) -> AnyPublisher<[User], ServiceError> {
        dbRepository.loadUsers()
            .map { $0
                .map { $0.toModel() }
                .filter { $0.id != id }
            }
            .mapError { .error($0) }
            .eraseToAnyPublisher()
        
    }
    
    func addUserAfterContact(users: [User]) -> AnyPublisher<Void, ServiceError> {
        dbRepository.addUserAfterContact(users: users.map { $0.toObject() })
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }
    
    func filterUsers(with queryString: String, userId: String) -> AnyPublisher<[User], ServiceError> {
        Empty().eraseToAnyPublisher()
    }
}

class StubUserService : UserServiceType {
    func addUser(_ user: User) -> AnyPublisher<User, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func getUser(userId: String) -> AnyPublisher<User, ServiceError> {
        Just(.stub1).setFailureType(to: ServiceError.self).eraseToAnyPublisher()
    }
    
    func getUser(userId: String) async throws -> User {
        return .stub1
    }
    
    func updateDescription(userId: String, value: String) async throws {
        return
    }
    
    func updateProfileURL(userId: String, urlString: String) async throws {
        return
    }
    
    func updateFCMToken(userId: String, fcmToken: String) -> AnyPublisher<Void, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func loadUser(id: String) -> AnyPublisher<[User], ServiceError> {
        Just([.stub1, .stub2]).setFailureType(to: ServiceError.self).eraseToAnyPublisher()
    }
    
    func addUserAfterContact(users: [User]) -> AnyPublisher<Void, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func filterUsers(with queryString: String, userId: String) -> AnyPublisher<[User], ServiceError> {
        Just([.stub1, .stub2]).setFailureType(to: ServiceError.self).eraseToAnyPublisher()
    }
}
