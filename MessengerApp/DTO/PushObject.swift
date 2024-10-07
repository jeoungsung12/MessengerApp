//
//  PushObject.swift
//  MessengerApp
//
//  Created by 정성윤 on 10/7/24.
//

import Foundation

struct PushObject: Encodable {
    var to: String
    
    struct NotificationObject: Encodable {
        var title: String
        var body: String
    }
}
