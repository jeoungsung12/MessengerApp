//
//  NavigationRouter.swift
//  MessengerApp
//
//  Created by 정성윤 on 9/2/24.
//

import Foundation
import Combine

class NavigationRouter: ObservableObject {
    
    @Published var destinations: [NavigationDestination] = []
    
    func push(to view: NavigationDestination) {
        destinations.append(view)
    }
    
    func pop() {
        _ = destinations.popLast()
    }
    
    func popToRootView() {
        destinations = []
    }
}
