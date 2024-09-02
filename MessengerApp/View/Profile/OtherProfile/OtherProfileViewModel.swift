//
//  OtherProfileViewModel.swift
//  MessengerApp
//
//  Created by 정성윤 on 9/2/24.
//

import Foundation
import Combine

class OtherProfileViewModel: ObservableObject {
     
    @Published var userInfo: User?
    
    private var userId: String
    private var container: DIContainer
    
    init(userId: String, container: DIContainer) {
        self.userId = userId
        self.container = container
    }
    
    @MainActor
    func getUser() async {
        if let user = try? await container.service.userService.getUser(userId: userId) {
            userInfo = user
        }
    }
}
