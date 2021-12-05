//
//  AdaptersTests.swift
//  AdaptersTests
//
//  Created by Ugur Unlu on 12/5/21.
//

import XCTest
import Entities
@testable import Adapters

class AdaptersTests: XCTestCase {
    func test_buildURLString_shouldBeEqual() throws {
        let expectedURL = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=28910e2945e62c2cf4c3f00d6ffb20b1&tags=utrecht&per_page=10&page=1&format=json&nojsoncallback=1"
            
        let urlString = EndpointFactory.photos(tags: "utrecht", perPage: 10, page: 1)
            .absoluteString.removingPercentEncoding
        
        XCTAssertEqual(urlString, expectedURL)
    }
    
    func test_map_photo_to_photoViewModel() {
        let photo = Photo(id: "51722062928", owner: "28169156@N03", secret: "52fe2850ef", server: "65535", farm: 66, title: "From another showroom")
        let viewModel = mapToViewModel(from: photo)
        let expectedURL = "https://farm66.static.flickr.com/65535/51722062928_52fe2850ef.jpg"
        XCTAssertEqual(viewModel.imageURLString, expectedURL)
        XCTAssertEqual(viewModel.title, photo.title)
    }

    func test_map_remotePhoto_to_containerPhotoViewModel() {
        let photo = Photo(id: "51722062928", owner: "28169156@N03", secret: "52fe2850ef", server: "65535", farm: 66, title: "From another showroom")
        let expectedURL = "https://farm66.static.flickr.com/65535/51722062928_52fe2850ef.jpg"
        let photos = Photos(page: 1, pages: 10, perpage: 10, total: 100, photo: [photo])
        let remotePhoto = RemotePhoto(photos: photos, stat: "")
        let containerPhotoViewModel = mapToContainerViewModel(from: remotePhoto.photos)
        
        XCTAssertEqual(containerPhotoViewModel.page, 1)
        XCTAssertEqual(containerPhotoViewModel.total, 100)
        XCTAssertEqual(containerPhotoViewModel.photos.count, 1)
        XCTAssertEqual(containerPhotoViewModel.photos.first?.imageURLString, expectedURL)
    }
    
    private func mapToContainerViewModel(from photos: Photos) -> ContainerPhotoViewModel {
        let photoViewModels = photos.photo
            .map { mapToViewModel(from: $0) }
        return .init(total: photos.total, page: photos.page, photos: photoViewModels)
    }
    
    private func mapToViewModel(from photo: Photo)-> PhotoViewModel {
        let urlString = "https://farm\(photo.farm).static.flickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"
        return .init(imageURLString: urlString, title: photo.title)
    }
}


