//
//  MainTabView.swift
//  MessengerApp
//
//  Created by 정성윤 on 8/7/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab : MainTabType = .home
    @EnvironmentObject var container : DIContainer
    @EnvironmentObject var authViewModel : AuthenticatedViewModel
    
    var body: some View {
        TabView(selection: $selectedTab)  {
            ForEach(MainTabType.allCases, id: \.self) { tab in
                Group {
                    switch tab {
                    case .home:
                        HomeView(viewModel: .init(container: container, userId: authViewModel.userId ?? ""))
                    case .chat:
                        ChatListiView()
                    case .phone:
                        Color.black
                    }
                }
                .tabItem {
                    Label(tab.title, image: tab.imageName(selected: selectedTab == tab))
                }
                .tag(tab)
            }
        }
        .tint(.black)
    }
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.black)
    }
}

#Preview {
    MainTabView()
}
