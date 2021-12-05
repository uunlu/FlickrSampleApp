//
//  PhotoViewModel.swift
//  FlickerSample
//
//  Created by Ugur Unlu on 12/5/21.
//

import Foundation

struct PhotoViewModel: Identifiable {
    let id: String = UUID().uuidString
    let imageURL: URL?
    let title: String
}
