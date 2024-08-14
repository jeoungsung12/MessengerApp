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
    var contactService : ContactServiceType { get set }
    var photoPickerService: PhotoPickerServiceType { get set }
}

class Services : ServiceType {
    var authService: AuthenticationServiceType
    var userService : UserServiceType
    var contactService: ContactServiceType
    var photoPickerService: PhotoPickerServiceType
    
    init() {
        self.authService = AuthenticationService()
        self.userService = UserService(dbRepository: UserDBRepository())
        self.contactService = ContactService()
        self.photoPickerService = PhotoPickerService()
    }
}

class StubService: ServiceType {
    var authService: AuthenticationServiceType = StubAuthenticationService()
    var userService: UserServiceType = StubUserService()
    var contactService: ContactServiceType = StubContactService()
    var photoPickerService: PhotoPickerServiceType = StubPhotoPickerService()
}
