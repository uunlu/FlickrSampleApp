//
//  CompositionRoot.swift
//  FlickerSample
//
//  Created by Ugur Unlu on 12/5/21.
//

import Foundation
import Adapters
import NetworkServices
import SwiftUI

enum CompositionRoot {
    static var composeApp: some View {
        let client = NetworkClient()
        let adapter = PhotoAdapter(service: client)
        let viewModel = PhotoContainerViewModel(service: adapter)
        return NavigationView {
            PhotoContainerView(viewModel: viewModel, detailsProvider: goToPhotos)
        }
    }
    
    private static func goToPhotos(viewModel: PhotoViewModel) -> AnyView {
        return PhotoDetailsView(model: viewModel).erased
    }
}

extension View {
    var erased: AnyView { AnyView(self) }
}
