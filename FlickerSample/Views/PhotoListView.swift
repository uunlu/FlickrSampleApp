//
//  PhotoListView.swift
//  FlickerSample
//
//  Created by Ugur Unlu on 12/5/21.
//

import SwiftUI

struct PhotoListView: View {
    @Binding var items: [PhotoViewModel]
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(items) { item in
                    HStack {
                        Text(item.title)
                    }
                }
            }
        }
    }
}

struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoListView(items:
                            .constant([.init(imageURL: "someURL", title: "Some Title")]
                                     ))
    }
}