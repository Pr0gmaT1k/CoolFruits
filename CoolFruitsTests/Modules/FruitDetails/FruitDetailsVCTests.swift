//
//  FruitDetailsVCTests.swift
//  CoolFruitsTests
//
//  Created by AzerTy on 03/04/2023.
//

import XCTest
@testable import CoolFruits

final class FruitDetailsVCTests: XCTestCase {
    // MARK: - Properties
    private var callDidFinish: XCTestExpectation?
    private var viewController: FruitDetailsVC!
    private var topLevelUIUtilities = TopLevelUIViewController<FruitDetailsVC>()
    
    // MARK:- Tests
    override func setUp() {
        super.setUp()
        var model = FruitModel()
        model.name = "foo"
        model.genus = "foo"
        model.family = "foo"
        viewController = FruitDetailsVC()
        viewController.fruit = model
        topLevelUIUtilities.setupTopLevelUI(with: viewController, inNavigationController: false)
    }
    
    override func tearDown() {
        super.tearDown()
        topLevelUIUtilities.tearDownTopLevelUI()
    }
    
    func testFill() {
        var model = FruitModel()
        model.name = "foo"
        model.genus = "foo"
        model.family = "foo"
        viewController.fill(fruit: model)
        XCTAssert(viewController.nameLabel.text == model.name)
        XCTAssert(viewController.genusLabel.text == "Genus: \(model.genus ?? "")")
        XCTAssert(viewController.familyLabel.text == "Family: \(model.family ?? "")")
    }
}


