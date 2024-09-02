//
//  URLImageView.swift
//  MessengerApp
//
//  Created by 정성윤 on 8/19/24.
//

import SwiftUI

struct URLImageView: View {
    @EnvironmentObject var container: DIContainer
    
    let urlString: String?
    let placeholderName: String
    
    init(urlString: String?, placeholderName: String? = nil) {
        self.urlString = urlString
        self.placeholderName = placeholderName ?? "placeholder"
    }
    
    var body: some View {
        if let urlString,!urlString.isEmpty {
            URLInnerImageView(viewModel: .init(urlString: urlString, container: container), placeholderName: placeholderName)
                .id(urlString)
        } else {
            Image(placeholderName)
                .resizable()
        }
    }
}

fileprivate struct URLInnerImageView: View {
    @StateObject var viewModel: URLImageViewModel
    
    let placeholderName: String
    
    var placeholderImage: UIImage {
        UIImage(named: placeholderName) ?? UIImage()
    }
    
    var body: some View {
        Image(uiImage: viewModel.loadedImage ?? placeholderImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .onAppear {
                if viewModel.loadingOrSuccess {
                    viewModel.start()
                }
            }
    }
}

#Preview {
    URLImageView(urlString: "")
}
