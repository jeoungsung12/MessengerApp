//
//  Services.swift
//  MessengerApp
//
//  Created by 정성윤 on 8/6/24.
//

import Foundation

protocol ServiceType {
    var authService : AuthenticationServiceType { get set }
    var userService : UserServiceType { get set }
}

class Services : ServiceType {
    var authService: AuthenticationServiceType
    var userService : UserServiceType
    init() {
        self.authService = AuthenticationService()
        self.userService = UserService(dbRepository: UserDBRepository())
    }
}

class StubService: ServiceType {
    var authService: AuthenticationServiceType = StubAuthenticationService()
    var userService: UserServiceType = StubUserService()
}
