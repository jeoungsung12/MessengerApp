//
//  AppDelegate.swift
//  MessengerApp
//
//  Created by 정성윤 on 8/7/24.
//

import SwiftUI
import Foundation
import FirebaseCore

class AppDelegate : NSObject, UIApplicationDelegate {
    func applicationDidFinishLaunching(_ application: UIApplication) {
        FirebaseApp.configure()
    }
}
