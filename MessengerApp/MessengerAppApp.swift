//
//  MessengerAppApp.swift
//  MessengerApp
//
//  Created by 정성윤 on 8/5/24.
//

import SwiftUI

@main
struct MessengerAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var container : DIContainer = .init(service: Services())
    
    var body: some Scene {
        WindowGroup {
            AuthenticatedView(authViewModel: .init(container: container))
                .environmentObject(container)
        }
    }
}
