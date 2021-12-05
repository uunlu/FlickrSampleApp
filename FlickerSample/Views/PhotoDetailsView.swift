//
//  PhotoDetailsView.swift
//  FlickerSample
//
//  Created by Ugur Unlu on 12/5/21.
//

import SwiftUI

struct PhotoDetailsView: View {
    let model: PhotoViewModel
    var body: some View {
        VStack {
            Text(model.title)
                .font(.title)
            Divider()
            AsyncImageView(url: model.imageURL){
                ProgressView()
            }
            Spacer()
        }
    }
}

struct PhotoDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetailsView(model: .init(imageURL:nil, title: "Some Title"))
    }
}
