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
    
    private var container : DIContainer
    private var userId : String
    
    init(container: DIContainer, userId : String) {
        self.container = container
        self.userId = userId
    }
    
}
