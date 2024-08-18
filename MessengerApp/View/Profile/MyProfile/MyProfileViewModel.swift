//
//  MyProfileViewModel.swift
//  MessengerApp
//
//  Created by 정성윤 on 8/14/24.
//

import Combine
import Foundation
import PhotosUI
import SwiftUI

@MainActor
class MyProfileViewModel : ObservableObject {
    
    @Published var userInfo: User?
    @Published var isPresentedDescEditView: Bool = false
    @Published var imageSelection: PhotosPickerItem? {
        didSet {
            Task {
                await updateProfileImage(pickerItem: imageSelection)
            }
        }
    }
    
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
    
    func updateProfileImage(pickerItem: PhotosPickerItem?) async {
        guard let pickerItem else { return }
        
        do {
            let data = try await container.service.photoPickerService.loadTransferable(from: pickerItem)
            let url = try await container.service.uploadService.uploadImage(source: .profile(userId: userId), data: data)
            try await container.service.userService.updateProfileURL(userId: userId, urlString: url.absoluteString)
            
            userInfo?.profileURL = url.absoluteString
        } catch {
            print("에러입니다 \(error.localizedDescription)")
        }
    }
}
