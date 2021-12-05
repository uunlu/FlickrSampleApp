//
//  PhotoListView.swift
//  FlickerSample
//
//  Created by Ugur Unlu on 12/5/21.
//

import SwiftUI

struct PhotoListView: View {
    @Binding var items: [PhotoViewModel]
    let loadMore: ()-> Void
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(items) { item in
                    HStack {
                        AsyncImageView(url: item.imageURL){
                            Text("Loading...")
                        }
                    }
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
    }
}

struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoListView(items:
                            .constant([.init(imageURL: URL(string: "http://some-url.com"), title: "Some Title")]
                                     ), loadMore: {})
    }
}
