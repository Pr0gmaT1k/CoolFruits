//
//  FruitsListVCTests.swift
//  CoolFruitsTests
//
//  Created by AzerTy on 03/04/2023.
//

import XCTest
@testable import CoolFruits

final class CoolFruitsTests: XCTestCase {
    // MARK: - Properties
    private var callDidFinish: XCTestExpectation?
    private var viewController: FruitsListVC!
    private var topLevelUIUtilities = TopLevelUIViewController<FruitsListVC>()
    
    // MARK:- Tests
    override func setUp() {
        super.setUp()
        viewController = FruitsListVC()
        viewController.delegate = self
        topLevelUIUtilities.setupTopLevelUI(with: viewController, inNavigationController: false)
    }
    
    override func tearDown() {
        super.tearDown()
        topLevelUIUtilities.tearDownTopLevelUI()
    }
    
    func testDidSelectFruit() {
        callDidFinish = expectation(description: "did finish")
        viewController.delegate?.didSelect(fruit: FruitModel(), animated: false)
        wait(for: callDidFinish!)
    }
    
    func testDidSelectRow() {
        callDidFinish = expectation(description: "did finish")
        viewController.presenter.displayedFruits = [FruitModel(), FruitModel()]
        viewController.fruitsTableView.reloadData()
        viewController.tableView(viewController.fruitsTableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        wait(for: callDidFinish!)
    }
}

// MARK:- UsersVC Delegate
extension CoolFruitsTests: FruitsListVCDelegate {
    func didSelect(fruit: CoolFruits.FruitModel, animated: Bool) {
        callDidFinish?.fulfill()
    }
}

