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
                TextField("Search...", text: $viewModel.searchText)
                PhotoListView(items: $viewModel.items, loadMore: viewModel.loadMore)
            }
            .padding()
            .onAppear {
                viewModel.load()
            }
            .navigationTitle("\(viewModel.model.total)  Photos")
    }
}

#if DEBUG
struct PhotoContainerView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoContainerView(viewModel: .init(service: PhotoLoaderSpy()))
    }
}
#endif
