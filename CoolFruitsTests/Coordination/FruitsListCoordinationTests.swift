//
//  FruitsListCoordinationTests.swift
//  CoolFruitsTests
//
//  Created by AzerTy on 03/04/2023.
//

import XCTest
@testable import CoolFruits

final class FruitsListsCoordinatorTests: XCTestCase {
    // MARK: - Properties
    private var coordinator: FruitsCoordinator!
    private var callDidFinish: XCTestExpectation?

    // MARK:- Tests
    override func setUp() {
        super.setUp()
        coordinator = FruitsCoordinator()
        coordinator.delegate = self
    }

    override func tearDown() {
        super.tearDown()
    }

    func testDidFinish() {
        callDidFinish = expectation(description: "did finish")
        coordinator.delegate?.fruitsListCoordinatorDidFinish(self.coordinator)
        wait(for: callDidFinish!)
    }
    
    func testDidSelectFruti() {
        coordinator.didSelect(fruit: FruitModel(), animated: false)
        XCTAssert(coordinator.rootViewController.presentedViewController == nil)
    }
}

// MARK:- Saved Coordinator Did finish
extension FruitsListsCoordinatorTests: FruitsCoordinatorDelegate {
    func fruitsListCoordinatorDidFinish(_ coordinator: CoolFruits.FruitsCoordinator) {
        callDidFinish?.fulfill()
    }
    
    func push(vc: UIViewController, animated: Bool) {}

    func pop(animated: Bool) {}
}
