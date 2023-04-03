//
//  LoaderViewTests.swift
//  CoolFruitsTests
//
//  Created by AzerTy on 03/04/2023.
//

import XCTest
@testable import CoolFruits

final class LoaderViewTests: XCTestCase {
    // MARK: - Properties
    private var viewController: UIViewController!
    private var topLevelUIUtilities = TopLevelUIViewController<UIViewController>()
    private var callDidFinish: XCTestExpectation?

    // MARK:- Tests
    override func setUp() {
        super.setUp()
        viewController = UIViewController()
        topLevelUIUtilities.setupTopLevelUI(with: viewController, inNavigationController: false)
    }

    override func tearDown() {
        super.tearDown()
        topLevelUIUtilities.tearDownTopLevelUI()
    }

    func testIsShownLoader() {
        XCTAssert(viewController.loaderIsShown == false)
    }

    func testShowLoader() {
        viewController.showLoader()
        XCTAssert(viewController.loaderIsShown)
    }

    func testInitWithCoder() {
        let someView = LoaderView(coder: NSCoder())
        XCTAssertNil(someView)
    }

    func testHideLoader() {
        viewController.showLoader()
        viewController.showLoader()
        callDidFinish = expectation(description: "did finish")
        XCTAssert(viewController.loaderIsShown)
        viewController.hideLoader(animated: true, completion: {
            if self.viewController.loaderIsShown == false {
                self.callDidFinish?.fulfill()
            }
        })
        wait(for: callDidFinish!, timeout: 5)
        XCTAssert(viewController.loaderIsShown == false)
    }

    func testHideLoaderAnimated() {
        viewController.showLoader()
        XCTAssert(viewController.loaderIsShown)
        viewController.hideLoader()
    }
}
