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
    @EnvironmentObject var navigationRouter: NavigationRouter
    
//    init() {
//        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.black)
//    }
    var body: some View {
        TabView(selection: $selectedTab)  {
            ForEach(MainTabType.allCases, id: \.self) { tab in
                Group {
                    switch tab {
                    case .home:
                        HomeView(viewModel: .init(container: container, userId: authViewModel.userId ?? "", navigationRouter: navigationRouter))
                            .environmentObject(navigationRouter)
                            .environmentObject(container)
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
}

struct MainTabView_Preview: PreviewProvider {
    static let container = DIContainer(service: StubService())
    static let navigationRouter: NavigationRouter = .init()
    static let authViewModel = AuthenticatedViewModel(container: Self.container)
    
    static var previews: some View {
        MainTabView()
            .environmentObject(Self.authViewModel)
            .environmentObject(Self.container)
            .environmentObject(Self.navigationRouter)
    }
}

