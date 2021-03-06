//
//  PhotoListView.swift
//  FlickerSample
//
//  Created by Ugur Unlu on 12/5/21.
//

import SwiftUI

struct PhotoListView: View {
    @Binding var items: [PhotoViewModel]
    @Binding var searchText: String
    let loadMore: ()-> Void
    let detailsProvider: (PhotoViewModel) -> AnyView
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        searchBar
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(items) { item in
                    navigationItem(item)
                }
            }
        }
    }
}

// MARK: - Extension UI components
extension PhotoListView {
    var searchBar: some View {
        TextField("Search...", text: $searchText)
            .autocapitalization(.none)
            .modifier(BoxModifier())
    }
    
    func navigationItem(_ item: PhotoViewModel) -> some View {
        NavigationLink(destination: detailsProvider(item)) {
            HStack {
                AsyncImageView(url: item.imageURL){
                    Text("Loading...")
                }
            }
            .frame(height: 200)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(.blue, lineWidth: 1))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .onAppear{
                if item.id == items.last?.id {
                    loadMore()
                }
            }
        }
    }
}

#if DEBUG
struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoListView(items:
                            .constant([.init(imageURL: URL(string: "http://some-url.com"), title: "Some Title")]
                                     ), searchText: .constant("search text"), loadMore: {}, detailsProvider: { _ in Text("Details").erased })
    }
}
#endif
