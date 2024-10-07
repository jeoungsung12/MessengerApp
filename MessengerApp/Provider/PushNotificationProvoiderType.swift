//
//  PushNotificationProvoiderType.swift
//  MessengerApp
//
//  Created by 정성윤 on 10/7/24.
//

import Foundation
import Combine

protocol PushNotificationProvoiderType {
    func sendPushNotification(object: PushObject) -> AnyPublisher<Bool, Never>
}

class PushNotificationProvoider: PushNotificationProvoiderType {
    
    private let serverURL: URL = URL(string: "https://fcm.googleapis.com/fcm/send")!
    private let serverKey = ""
    
    func sendPushNotification(object: PushObject) -> AnyPublisher<Bool, Never> {
        var request = URLRequest(url: serverURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=\(serverKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(object)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { _ in true }
            .replaceError(with: false)
            .eraseToAnyPublisher()
    }
    
}
