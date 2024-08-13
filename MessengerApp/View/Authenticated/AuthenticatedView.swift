//
//  ContentView.swift
//  MessengerApp
//
//  Created by 정성윤 on 8/5/24.
//

import SwiftUI

struct AuthenticatedView: View {
    @EnvironmentObject var container : DIContainer
    @StateObject var authViewModel : AuthenticatedViewModel
    
    var body: some View {
        VStack {
            switch authViewModel.authenticationState {
            case .unauthenticated:
                LoginIntroView()
                    .environmentObject(authViewModel)
            case .authenticated:
                MainTabView()
                    .environmentObject(authViewModel)
            }
        }
        .onAppear {
            authViewModel.send(action: .checkAuthenticationState)
//            authViewModel.send(action: .logout)
        }
    }
}

struct AuthenticatedView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticatedView(authViewModel: .init(container: .init(service: StubService())))
    }
}
