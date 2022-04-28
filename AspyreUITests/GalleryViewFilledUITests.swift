//
//  GalleryViewFilledUITests.swift
//  AspyreUITests
//

import XCTest

class GalleryViewFilledUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app.launch()
    }
    
    // MARK: - Search a text

    /// After some seconds the grid should be filled with the specified photo elements in photos per page
    func test_searchText_gridHasNElements() {

        let searchBarTextField = app.textFields[Constants.searchViewTextFieldIdentifier]
        let searchButton = app.images[Constants.searchViewButtonIdentifier]

        searchBarTextField.tap()
        searchBarTextField.typeText("John")
        searchButton.tap()

        // First page

        let expectation1 = XCTestExpectation(description: "Grid has been filled with results")
        let result1 = XCTWaiter.wait(
            for: [expectation1],
            timeout: 4.0
        )
        
        let images = app.images.matching(identifier: Constants.photoImageViewIdentifier)

        switch result1 {
        case .timedOut: XCTAssert(images.count >= Constants.photosPerPage, "Grid elements don't match photos per page")
        default: XCTFail("Delay interrupted")
        }

    }
}
