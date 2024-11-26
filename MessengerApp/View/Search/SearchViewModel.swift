//
//  SearchViewModel.swift
//  MessengerApp
//
//  Created by 정성윤 on 10/7/24.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    
    enum Action {
        case requestQuery(String)
        case clearSearchResult
    }
    @Published var shouldBecomeFirstResponder: Bool = false
    @Published var searchText: String = ""
    @Published var searchResult: [User] = []
    
    private let userId: String
    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(userId: String, container: DIContainer) {
        self.userId = userId
        self.container = container
        
        bind()
    }
    
    func bind() {
        $searchText
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] text in
                if text.isEmpty {
                    self?.send(action: .clearSearchResult)
                } else {
                    self?.send(action: .requestQuery(text))
                }
            }.store(in: &subscriptions)
    }
    
    func send(action: Action) {
        switch action {
        case let.requestQuery(query):
            container.service.userService.filterUsers(with: query, userId: userId)
                .sink { completion in
                    
                } receiveValue: { [weak self] users in
                    self?.searchResult = users
                }.store(in: &subscriptions)
        case .clearSearchResult:
            searchResult = []
        }
    }
}
