//
//  AsyncImageView.swift
//  FlickerSample
//
//  Created by Ugur Unlu on 12/5/21.
//

import SwiftUI

struct AsyncImageView<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    private let placeHolder: Placeholder
    private let url: URL?
    
    init(url: URL?, @ViewBuilder view: () -> Placeholder) {
        self.placeHolder = view()
        self.url = url
        _loader = StateObject(wrappedValue: ImageLoader())
    }
    
    var body: some View {
        content
            .onAppear(perform: { loader.load(url: url) } )
    }
    
    private var content: some View {
        Group {
            if let img = loader.image {
                Image(uiImage: img)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }else {
                placeHolder
            }
        }
    }
}

