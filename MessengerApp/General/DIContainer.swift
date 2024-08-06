//
//  DIContainer.swift
//  MessengerApp
//
//  Created by 정성윤 on 8/6/24.
//

import Foundation

class DIContainer : ObservableObject {
    var service : ServiceType
    
    init(service: ServiceType) {
        self.service = service
    }
    
}
