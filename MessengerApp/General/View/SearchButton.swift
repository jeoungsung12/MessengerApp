//
//  SearchButton.swift
//  MessengerApp
//
//  Created by 정성윤 on 9/2/24.
//

import SwiftUI

struct SearchButton: View {
    var body: some View {
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
}

#Preview {
    SearchButton()
}
