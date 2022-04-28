//
//  GalleryViewModelTests.swift
//  AspyreTests
//

import XCTest
import Moya
@testable import Aspyre

class GalleryViewModelTests: XCTestCase {
    
    var sut: GalleryViewModel!
    
    override func setUpWithError() throws {
        let moyaProvider = MoyaProvider<GalleryApi>()
        let galleryService = GalleryNetworkService(provider: moyaProvider)
        sut = GalleryViewModel(galleryService: galleryService)
    }
    
    /// When a new contact name is searched, the variables are reset (photos array, page index), and the new photos are loaded
    func test_newName_loadAndresetVariables() {
        
        sut.searchContactName = "John"
        sut.reload()
        
        let expectation = XCTestExpectation(description: "photos array to have values")
        let result = XCTWaiter.wait(
            for: [expectation],
            timeout: 3.0
        )
        
        switch result {
        case .timedOut: XCTAssertTrue(sut.photos.count >= Constants.photosPerPage)
        default: XCTFail("Delay interrupted")
        }
        
        sut.searchContactName = "Tracy"
        sut.reload()
    
        XCTAssertEqual(sut.photos.count, 0, "Previous photos were not removed")
        XCTAssertEqual(sut.page, Constants.initialPage, "Previous photos were not removed and page not reset")
        
    }
    
    /// - increases the page index
    /// - Adds the right number of photos per page
    func test_loadMore_addsMorePhotos() {
        
        sut.searchContactName = "Jason"
        sut.reload()
        
        XCTAssertEqual(sut.page, Constants.initialPage)
        
        let expectation = XCTestExpectation(description: "photos array to have values")
        let result = XCTWaiter.wait(
            for: [expectation],
            timeout: 3.0
        )
        
        switch result {
        case .timedOut:
            
            let firstLoadPhotosCount = sut.photos.count
            
            sut.loadMorePhotos()
            XCTAssertEqual(sut.page, Constants.initialPage + 1)
            
            let expectation1 = XCTestExpectation(description: "photos array to have more values than before")
            let result1 = XCTWaiter.wait(
                for: [expectation1],
                timeout: 3.0
            )
            
            switch result1 {
            case .timedOut:
                
                let secondLoadPhotosCount = sut.photos.count
                XCTAssertTrue(secondLoadPhotosCount > firstLoadPhotosCount)
                
            default: XCTFail("Second delay interrupted")
            }
            
            
        default: XCTFail("Delay interrupted")
        }
        
    }
    
}
