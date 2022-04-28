//
//  GalleryViewUITests.swift
//  AspyreUITests
//

import XCTest
@testable import Aspyre

class GalleryViewEmptyUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app.launch()
    }
    
    // MARK: - Search is empty
    
    /// - There should be a text indicating what to do
    /// - There should be a search bar with a text indicating what to search
    func test_searchIsEmpty() {
        
        let blankPageDescriptionText = app.staticTexts[Constants.welcomeTextIdentifier]
        let searchViewText = app.staticTexts[Constants.searchViewTextIdentifier]
        let grid = app.grids[Constants.photosGridIdentifier]
        
        XCTAssert(blankPageDescriptionText.exists)
        XCTAssertEqual(blankPageDescriptionText.label, L10n.findPhotos, "Empty state label is not correct")
        
        XCTAssert(searchViewText.exists)
        XCTAssertEqual(searchViewText.label, L10n.search, "Empty search label is not correct")
        
        XCTAssertFalse(grid.exists)
    }

}
