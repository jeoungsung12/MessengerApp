//
//  User.swift
//  MessengerApp
//
//  Created by 정성윤 on 8/8/24.
//

import Foundation

struct User {
    var id : String
    var name : String
    var phoneNumber : String?
    var profileURL : String?
    var description : String?
}

extension User {
    static var stub1: User {
        .init(id: "user1_id", name: "김하늘")
    }
    static var stub2: User {
        .init(id: "user2_id", name: "김코랄")
    }
}
    
