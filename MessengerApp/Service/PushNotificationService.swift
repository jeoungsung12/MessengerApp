//
//  PushNotificationService.swift
//  MessengerApp
//
//  Created by 정성윤 on 10/7/24.
//

import Foundation
import Combine
import FirebaseMessaging

protocol PushNotificationServiceType {
    var fcmToken: AnyPublisher<String?, Never> { get }
    func requestAuthorization(completion: @escaping (Bool) -> Void)
    func sendPushNotification(fcmToken: String, message: String) -> AnyPublisher<Bool, Never>
}

class PushNotificationService: NSObject, PushNotificationServiceType {
    
    var provider: PushNotificationServiceType
    
    var fcmToken: AnyPublisher<String?, Never> {
        _fcmToken.eraseToAnyPublisher()
    }
    
    private let _fcmToken = CurrentValueSubject<String?, Never>(nil)
    
    init(provider: PushNotificationServiceType) {
        self.provider = provider
        super.init()
        
        Messaging.messaging().delegate = self
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { granted, error in
            if error != nil {
                completion(false)
            } else {
                completion(granted)
            }
        }
    }
    
    func sendPushNotification(fcmToken: String, message: String) -> AnyPublisher<Bool, Never> {
        provider.sendPushNotification(fcmToken: fcmToken, message: message)
    }
}
extension PushNotificationService: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("messaging:didReceiveRegistrationToken:", fcmToken ?? "")
        
        guard let fcmToken else { return }
        _fcmToken.send(fcmToken)
    }
}

class StubPushNotificationService: PushNotificationServiceType {
    var fcmToken: AnyPublisher<String?, Never> {
        Empty().eraseToAnyPublisher()
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) { }
    
    func sendPushNotification(fcmToken: String, message: String) -> AnyPublisher<Bool, Never> {
        Empty().eraseToAnyPublisher()
    }
}
