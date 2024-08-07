//
//  ContentView.swift
//  MessengerApp
//
//  Created by 정성윤 on 8/5/24.
//

import SwiftUI

struct AuthenticatedView: View {
    @StateObject var authViewModel : AuthenticatedViewModel
    var body: some View {
        switch authViewModel.authenticationState {
        case .unauthenticated:
            LoginIntroView()
        case .authenticated:
            MainTabView()
        }
    }
}

struct AuthenticatedView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticatedView(authViewModel: .init(container: .init(service: StubService())))
    }
}
