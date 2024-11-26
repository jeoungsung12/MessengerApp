//
//  SearchBar.swift
//  MessengerApp
//
//  Created by 정성윤 on 10/7/24.
//

import Foundation
import SwiftUI

struct SearchBar: UIViewRepresentable {
    @Binding var searchText: String
    @Binding var shouldBecomeFirstResponder: Bool
    init(text: Binding<String>, shouldBecomeFirstResponder: Binding<Bool>) {
        self._searchText = text
        self._shouldBecomeFirstResponder = shouldBecomeFirstResponder
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $searchText)
    }
    
    func makeUIView(context: Context) -> some UIView {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = context.coordinator
        return searchBar
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

extension SearchBar {
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.text = searchText
        }
    }
}
