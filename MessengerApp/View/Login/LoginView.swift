//
//  LoginView.swift
//  MessengerApp
//
//  Created by 정성윤 on 8/7/24.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    var body: some View {
        @Environment(\.dismiss) var dismiss
        @EnvironmentObject var authViewModel: AuthenticatedViewModel
        
        
        VStack(alignment: .leading, spacing: 20) {
            Group {
                Text("로그인")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.top, 80)
                
                Text("아래 제공되는 서비스로 로그인을 해주세요.")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 30)
            
            Spacer()
            
            Button(action: {
                authViewModel.send(action: .googleLogin)
                //Thread 1: Fatal error: No ObservableObject of type AuthenticatedViewModel found. A View.environmentObject(_:) for AuthenticatedViewModel may be missing as an ancestor of this view.
            }, label: {
                Text("Google로 로그인")
            }).buttonStyle(LoginButtonStyle(textColor: .black, borderColor: .gray))
            
            SignInWithAppleButton { request in
                authViewModel.send(action: .appleLogin(request))
            } onCompletion: { result in
                authViewModel.send(action: .appleLoginCompletion(result))
            }
            .cornerRadius(5)
            .frame(height: 50)
            .padding(.horizontal, 15)
            .padding(.bottom, 30)

        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label : {
                    Image("back")
                }
            }
        }
        .overlay {
            if authViewModel.isLoading {
                ProgressView()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthenticatedViewModel(container: .init(service: Services())))
    }
}
