//
//  LoginButtonStyle.swift
//  MessengerApp
//
//  Created by 정성윤 on 8/8/24.
//

import SwiftUI
import Foundation

struct LoginButtonStyle : ButtonStyle {
    let textColor : Color
    let borderColor : Color
    
    init(textColor: Color, borderColor : Color? = nil) {
        self.textColor = textColor
        self.borderColor = borderColor ?? textColor
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 14))
            .foregroundColor(self.textColor)
            .frame(maxWidth: .infinity, maxHeight: 50)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(self.borderColor, lineWidth: 0.8)
            }
            .padding(.horizontal, 15)
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
    
}
