//
//  ContainerPhotoViewModel.swift
//  Adapters
//
//  Created by Ugur Unlu on 12/5/21.
//

import Foundation

public struct ContainerPhotoViewModel {
    let total: Int
    let page: Int
    let photos: [PhotoViewModel]
}

extension ContainerPhotoViewModel {
    public static var sample: ContainerPhotoViewModel {
        let photoViewModel = PhotoViewModel(imageURLString: "https://some-url.com", title: "Sample title")
        return .init(total: 1, page: 1, photos: [photoViewModel])
    }
}
