//
//  ChatImageItemView.swift
//  MessengerApp
//
//  Created by 정성윤 on 9/12/24.
//

import SwiftUI

struct ChatImageItemView: View {
    let urlString: String
    let direction: ChatItemDirection
    
    var body: some View {
        HStack {
            if direction == .right {
                Spacer()
            }
            URLImageView(urlString: urlString)
                .frame(width: 146, height: 144)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            if direction == .left {
                Spacer()
            }
        }
        .padding(.horizontal, 35)
    }
}

#Preview {
    ChatImageItemView(urlString: "", direction: .right)
}
