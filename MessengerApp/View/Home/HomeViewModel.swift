//
//  HomeViewModel.swift
//  MessengerApp
//
//  Created by 정성윤 on 8/10/24.
//

import Foundation

class HomeViewModel : ObservableObject {
    @Published var myUser : User?
    @Published var users : [User] = [.stub1, .stub2]
}
