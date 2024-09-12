//
//  ChatItemDirection.swift
//  MessengerApp
//
//  Created by 정성윤 on 9/4/24.
//

import Foundation
import SwiftUI

enum ChatItemDirection {
    case left
    case right
    
    var backgroundColor: Color {
        switch self {
        case .left:
            return .white
        case .right:
            return .color7
        }
    }
    
    var overlayAlignment: Alignment {
        switch self {
        case .left:
            return .topLeading
        case .right:
            return .topTrailing
        }
    }
    
    var overlayImage: Image {
        switch self {
        case .left:
            return Image("bubble_tail_left")
        case .right:
            return Image("bubble_tail_right")
        }
    }
}
