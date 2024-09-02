//
//  OtherProfileMenuType.swift
//  MessengerApp
//
//  Created by 정성윤 on 9/2/24.
//

import Foundation
import UIKit

enum OtherProfileMenuType: Hashable, CaseIterable {
    case message
    case call
    case video
    
    var description: String {
        switch self {
        case .message:
            return "대화"
        case .call:
            return "음성통화"
        case .video:
            return "영상통화"
        }
    }
    
    var imageName: String {
        switch self {
        case .message:
            return "message"
        case .call:
            return "call"
        case .video:
            return "video"
        }
    }
}
