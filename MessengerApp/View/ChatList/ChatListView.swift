//
//  ChatListView.swift
//  MessengerApp
//
//  Created by 정성윤 on 8/10/24.
//

import SwiftUI

struct ChatListView: View {
    @StateObject var viewModel: ChatListViewModel
    @EnvironmentObject var navigationRouter: NavigationRouter
    
    var body: some View {
        NavigationStack(path: $navigationRouter.destinations) {
            ScrollView {
                NavigationLink(value: NavigationDestination.search) {
                    SearchButton()
                }
                .padding(.top, 14)
                .padding(.bottom, 14)
                
                ForEach(viewModel.chatRooms, id: \.self) { chatRoom in
                    ChatRoomCell(chatRoom: chatRoom, userId: viewModel.userId)
                }
                
            }
            .navigationTitle("대화")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: NavigationDestination.self) {
                NavigationRoutingView(destination: $0)
            }
            .onAppear {
                viewModel.send(action: .load)
            }
        }
    }
}

fileprivate struct ChatRoomCell: View {
    let chatRoom: ChatRoom
    let userId: String
    
    var body: some View {
        NavigationLink(value: NavigationDestination.chat(chatRoomId: chatRoom.chatRoomId, myUserId: userId, otherUserId: chatRoom.otherUserId)) {
            HStack(spacing: 8) {
                Image("person")
                    .resizable()
                    .frame(width: 40, height: 40)
                VStack(alignment: .leading, spacing: 3) {
                    Text(chatRoom.otherUserName)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                    if let lastMessage = chatRoom.lastMessage {
                        Text(lastMessage)
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 17)
        }
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var navigationRouter: NavigationRouter = .init()
    static var previews: some View {
        ChatListView(viewModel: ChatListViewModel(container: .init(service: StubService()), userId: ""))
            .environmentObject(Self.navigationRouter)
    }
}
