//
//  NavigationRoutingView.swift
//  MessengerApp
//
//  Created by 정성윤 on 9/2/24.
//

import SwiftUI

struct NavigationRoutingView: View {
    @State var destination: NavigationDestination
    @EnvironmentObject var container: DIContainer
    
    var body: some View {
        switch destination {
        case let .chat(chatRoomId, myUserId, otherUserId):
            ChatView(viewModel: .init(chatRoomId: chatRoomId, myUserId: myUserId, otherUserId: otherUserId, container: self.container))
        case .search:
            SearchView()
        }
    }
}
