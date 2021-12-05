//
//  PhotoContainerView.swift
//  FlickerSample
//
//  Created by Ugur Unlu on 12/5/21.
//

import SwiftUI

struct PhotoContainerView: View {
    @StateObject var viewModel: PhotoContainerViewModel
    
    var body: some View {
            VStack {
                photoList
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .padding()
            .onAppear {
                viewModel.load()
            }
            .navigationTitle("\(viewModel.model.total)  Photos")
    }
}

// MARK: - Extensions
extension PhotoContainerView {
    var photoList: some View {
        PhotoListView(items: $viewModel.items, searchText: $viewModel.searchText, loadMore: viewModel.loadMore)
    }
}

#if DEBUG
struct PhotoContainerView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoContainerView(viewModel: .init(service: PhotoLoaderSpy()))
    }
}
#endif
