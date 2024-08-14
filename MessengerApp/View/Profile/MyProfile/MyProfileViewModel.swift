//
//  MyProfileViewModel.swift
//  MessengerApp
//
//  Created by 정성윤 on 8/14/24.
//

import Combine
import Foundation

class MyProfileViewModel : ObservableObject {
    
    @Published var userInfo: User?
    @Published var isPresentedDescEditView: Bool = false
    
    private var container : DIContainer
    private var userId : String
    
    init(container: DIContainer, userId : String) {
        self.container = container
        self.userId = userId
    }
    
    func getUser() async {
        if let user = try? await container.service.userService.getUser(userId: userId) {
            userInfo = user
        }
    }
    
    func updateDescription(_ description: String) async {
        do {
            try await container.service.userService.updateDescription(userId: userId, value: description)
            userInfo?.description = description
        } catch {
            
        }
    }
}
