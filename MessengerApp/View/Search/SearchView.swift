//
//  SearchView.swift
//  MessengerApp
//
//  Created by 정성윤 on 9/2/24.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var navigationRouter: NavigationRouter
    @StateObject var searchViewModel: SearchViewModel

    var body: some View {
        VStack {
            topView
            
            List {
                ForEach(searchViewModel.searchResult, id: \.self) { result in
                    HStack(spacing: 8) {
                        URLImageView(urlString: result.profileURL)
                            .frame(width: 26, height: 26)
                            .clipShape(Circle())
                        Text(result.name)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.black)
                    }
                    .listRowInsets(.init())
                    .listRowSeparator(.hidden)
                    .padding(.horizontal, 30)
                }
            }
            .listStyle(.plain)
        }
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
    }
    var topView: some View {
        HStack(spacing: 0) {
            Button {
                navigationRouter.pop()
            } label: {
                Image("back")
            }
            SearchBar(text: $searchViewModel.searchText)
            
            Button {
                //TODO: -
            } label: {
                Image("close")
                    .background(.gray)
                    .cornerRadius(15)
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    SearchView(searchViewModel: SearchViewModel(userId: "", container: .init(service: StubService())))
        .environmentObject(NavigationRouter())
}
