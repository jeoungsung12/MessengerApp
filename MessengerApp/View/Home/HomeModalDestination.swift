//
//  HomeModalDestination.swift
//  MessengerApp
//
//  Created by 정성윤 on 8/14/24.
//

import Foundation

enum HomeModalDestination: Hashable, Identifiable {
    case myProfile
    case otherProfile(String)
    
    var id: Int {
        hashValue
    }
}
