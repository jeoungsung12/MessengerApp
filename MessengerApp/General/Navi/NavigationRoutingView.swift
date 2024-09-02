//
//  NavigationRoutingView.swift
//  MessengerApp
//
//  Created by 정성윤 on 9/2/24.
//

import SwiftUI

struct NavigationRoutingView: View {
    @State var destination: NavigationDestination
    
    var body: some View {
        switch destination {
        case .chat:
            ChatView()
        case .search:
            SearchView()
        }
    }
}
