//
//  PhotoContainerView.swift
//  FlickerSample
//
//  Created by Ugur Unlu on 12/5/21.
//

import SwiftUI

struct PhotoContainerView: View {
    @StateObject var viewModel: PhotoContainerViewModel
    @State private var showHistory = false
    let detailsProvider: (PhotoViewModel) -> AnyView
    
    var body: some View {
            VStack {
                    photoList
                    if viewModel.isLoading {
                        ProgressView()
                    }
                ErrorView(isShowing: $viewModel.hasError, message: viewModel.errorMessage)
                }
                .padding()
                .onAppear {
                    viewModel.load()
                }
                .navigationTitle("\(viewModel.model.total)  Photos")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        historyButton
                    }
                }
                .sheet(isPresented: $showHistory, onDismiss: {
                    
                }, content: {
                    HistoryView(items: viewModel.searchTerms, searchText: $viewModel.searchText)
            })
    }
}

// MARK: - Extensions
extension PhotoContainerView {
    var photoList: some View {
        PhotoListView(items: $viewModel.items, searchText: $viewModel.searchText, loadMore: viewModel.loadMore, detailsProvider: detailsProvider)
    }
    
    var historyButton: some View {
        HStack {
            Button {
                showHistory.toggle()
            } label: {
                Image(systemName: "lineweight")
                    .padding()
            }
        }
    }
}

#if DEBUG
struct PhotoContainerView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoContainerView(viewModel: .init(service: PhotoLoaderSpy()), detailsProvider: { _ in Text("Photo details").erased })
    }
}
#endif
