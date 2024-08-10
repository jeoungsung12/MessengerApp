//
//  HomeView.swift
//  MessengerApp
//
//  Created by 정성윤 on 8/10/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel : HomeViewModel
    var body: some View {
        NavigationStack {
            ScrollView {
                profileView
                    .padding(.bottom, 30)
                searchButton
                    .padding(.bottom, 30)
                
                HStack {
                    Text("친구")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.horizontal, 30)
                
                if viewModel.users.isEmpty {
                    Spacer(minLength: 89)
                    emptyView
                } else {
                    ForEach(viewModel.users, id: \.id) { user in
                        HStack(spacing: 8) {
                            Image("person")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                            Text(user.name)
                                .font(.system(size: 12))
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding(.horizontal, 30)
                    }
                }
            }
            .toolbar {
                Image("bookmark")
                Image("notifications")
                Image("person_add")
                Button {
                    // TODO:
                } label: {
                    Image("settings")
                }
            }
        }
    }
    var profileView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 7) {
                Text(viewModel.myUser?.name ?? "이름")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor((.black))
                Text(viewModel.myUser?.description ?? "상태 메시지 입력")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor((.gray))
            }
            Spacer()
            
            Image("person")
                .resizable()
                .frame(width: 52, height: 52)
                .clipShape(Circle())
        }
        .padding(.horizontal, 30)
    }
    var searchButton : some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 36)
                .background(Color.Color4)
                .cornerRadius(5)
            HStack {
                Text("검색")
                    .font(.system(size: 12))
                    .foregroundColor(.black)
                Spacer()
            }
            .padding(.leading, 22)
        }
        .padding(.horizontal, 30)
    }
    var emptyView: some View {
        VStack {
            VStack(spacing: 3) {
                Text("친구를 추가해보세요.")
                    .foregroundColor(.black)
                Text("큐알코드나 검색을 이용해서 친구를 추가해보세요.")
                    .foregroundColor(.gray)
            }
            .font(.system(size: 14))
            .padding(.bottom, 30)
            
            Button {
                
            } label : {
                Text("친구추가")
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                    .padding(.vertical, 9)
                    .padding(.horizontal, 24)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.Color4)
            }
        }
    }
}

#Preview {
    HomeView(viewModel: .init())
}
