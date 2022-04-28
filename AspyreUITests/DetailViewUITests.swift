//
//  DetailViewUITests.swift
//  AspyreUITests
//

import XCTest
@testable import Aspyre

class DetailViewUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app.launch()
    }
    
    func test_detailLoad() {
        
        navigateToAnyDetail()
        
        let image = app.images[Constants.detailImageIdentifier]
        let ownerText = app.staticTexts[Constants.detailOwnerTextIdentifier]
        let dateText = app.staticTexts[Constants.detailDateTextIdentifier]
        let descText = app.staticTexts[Constants.detailDescriptionTextIdentifier]
        let browserButton = app.buttons[Constants.detailBrowserButtonIdentifier]
        
        XCTAssert(image.waitForExistence(timeout: 0.5))
        XCTAssert(ownerText.waitForExistence(timeout: 0.5))
        XCTAssert(dateText.waitForExistence(timeout: 0.5))
        XCTAssert(descText.waitForExistence(timeout: 0.5))
        XCTAssert(browserButton.waitForExistence(timeout: 0.5))
        
        XCTAssertNotNil(image.value)
        XCTAssertNotNil(ownerText.value)
        XCTAssertNotNil(dateText.value)
        XCTAssertNotNil(descText.value)
        XCTAssertEqual(browserButton.label, L10n.openInBrowser)
    }
    
    private func navigateToAnyDetail() {
        
        let searchBarTextField = app.textFields[Constants.searchViewTextFieldIdentifier]
        let searchButton = app.images[Constants.searchViewButtonIdentifier]

        searchBarTextField.tap()
        searchBarTextField.typeText("John")
        searchButton.tap()
        
        let images = app.images.matching(identifier: Constants.photoImageViewIdentifier)
        
        images.firstMatch.tap()
    }
}
