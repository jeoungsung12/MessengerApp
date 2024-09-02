//
//  OtherProfileView.swift
//  MessengerApp
//
//  Created by 정성윤 on 8/14/24.
//

import SwiftUI

struct OtherProfileView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel : OtherProfileViewModel
    
    var goToChat: (User) -> Void
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("profile_bg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea(edges: .vertical)
                
                
                VStack(spacing: 0) {
                   Spacer()
                    
                    URLImageView(urlString: viewModel.userInfo?.profileURL)
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .padding(.bottom, 16)
                    
                    Text(viewModel.userInfo?.name ?? "이름")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    menuView
                        .padding(.bottom, 58)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image("close")
                    })
                }
            }
            .task {
                await viewModel.getUser()
            }
        }
    }

    
    var nameView: some View {
        Text(viewModel.userInfo?.name ?? "이름")
            .font(.system(size: 24, weight: .bold))
            .foregroundStyle(.white)
    }

    
    var menuView: some View {
        HStack(alignment: .top, spacing: 27) {
            ForEach(OtherProfileMenuType.allCases, id: \.self) { menu in
                Button(action: {
                    if menu == .message, let userInfo = viewModel.userInfo {
                        dismiss()
                        goToChat(userInfo)
                    }
                }, label: {
                    VStack(alignment: .center) {
                        Image(menu.imageName)
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text(menu.description)
                            .font(.system(size: 10))
                            .foregroundStyle(.white)
                    }
                })
            }
        }
    }
}

#Preview {
    OtherProfileView(viewModel: OtherProfileViewModel(userId: "", container: .init(service: StubService()))) { _ in
    }
}
