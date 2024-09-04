//
//  ChatVview.swift
//  MessengerApp
//
//  Created by 정성윤 on 9/2/24.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var navigationRouter: NavigationRouter
    @StateObject var viewModel: ChatViewModel
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ScrollView {
            if viewModel.chatDataList.isEmpty {
                Color.color7
            } else {
                contentView
            }
        }
        .background(Color.color3)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .toolbarBackground(Color.color3, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    navigationRouter.pop()
                } label: {
                    Image("back")
                }
                
                Text(viewModel.otherUser?.name ?? "대화방이름")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
            }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Image("search_chat")
                Image("bookmark")
                Image("settings")
            }
        }
        .keyboardToolBar(height: 50) {
            HStack(spacing: 13) {
                Button {
                    
                } label: {
                    Image("other_add")
                }
                Button {
                    
                } label: {
                    Image("image_add")
                }
                Button {
                    
                } label: {
                    Image("photo_camera")
                }
                
                TextField("", text: $viewModel.message)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .focused($isFocused)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 13)
                    .background(Color.Color4)
                    .cornerRadius(20)
                
                Button {
                    viewModel.send(action: .addChat(viewModel.message))
                    isFocused = false
                } label: {
                    Image("send")
                }
            }
            .padding(.horizontal, 27)
        }
        .onAppear {
            viewModel.send(action: .load)
        }
    }
    
    var contentView: some View {
        ForEach(viewModel.chatDataList) { chatData in
            Section {
                ForEach(chatData.chats) { chat in
                    ChatItemView(message: chat.message ?? "", direction: viewModel.getDirection(id: chat.userId), date: chat.date)
                }
            } header: {
                headerView(dateStr: chatData.dateStr)
            }
        }
    }
    
    func headerView(dateStr: String) -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width:76, height: 20)
                .background(Color.gray)
                .cornerRadius(50)
            Text(dateStr)
                .font(.system(size: 10))
                .foregroundColor(.white)
        }
    }
}

#Preview {
    NavigationStack {
        ChatView(viewModel: ChatViewModel(chatRoomId: "chatRoom1_id", myUserId: "user1_id", otherUserId: "user2_id", container: DIContainer(service: StubService())))
            .environmentObject(NavigationRouter())
    }
}
