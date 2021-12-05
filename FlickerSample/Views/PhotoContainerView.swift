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
            LazyVStack {
                ForEach(viewModel.model.photos) {
                    Text($0.title)
                    Text($0.imageURLString)
                }
            }
            .onAppear {
                viewModel.load()
            }
            .navigationTitle("\(viewModel.model.total)  Photos")
    }
}

struct PhotoContainerView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoContainerView(viewModel: .init(service: PhotoLoaderSpy()))
    }
}
