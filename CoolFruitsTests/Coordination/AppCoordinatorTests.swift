//
//  AppCoordinatorTests.swift
//  CoolFruitsTests
//
//  Created by AzerTy on 03/04/2023.
//


import XCTest
@testable import CoolFruits

final class AppCoordinatorTests: XCTestCase {
    // MARK: - Properties
    private var coordinator: AppCoordinator!
    private var callDidFinish: XCTestExpectation?

    // MARK:- Tests
    override func setUp() {
        super.setUp()
        coordinator = AppCoordinator(window: UIWindow())
        coordinator.start()
        coordinator.delegate = self
    }

    override func tearDown() {
        super.tearDown()
    }

    func testDidFinish() {
        callDidFinish = expectation(description: "did finish")
        coordinator.delegate?.appCoordinatorDidFinish(coordinator)
        wait(for: callDidFinish!)
    }
    
    func testDidFinishFruits() {
        callDidFinish = expectation(description: "did finish")
        (coordinator.childCoordinators.first as? FruitsCoordinator)?.delegate?.fruitsListCoordinatorDidFinish(FruitsCoordinator())
        wait(for: callDidFinish!)
    }

    func testChildCoordinator() {
        coordinator.addChildCoordinator(coordinator)
        XCTAssert(coordinator.childCoordinators.count == 2)
        coordinator.removeChildCoordinator(coordinator)
        XCTAssert(coordinator.childCoordinators.count == 1)
    }

    func testPresentCoordinator() {
        coordinator.presentCoordinator(FruitsCoordinator(), animated: true)
        XCTAssert(coordinator.childCoordinators.last is FruitsCoordinator)
    }

    func testDismissCoordinator() {
        let fruits = AppCoordinator(window: UIWindow())
        coordinator.presentCoordinator(fruits, animated: true)
        coordinator.dismissCoordinator(fruits, animated: true)
        XCTAssert((coordinator.childCoordinators.last is AppCoordinator) == false)
    }
}

// MARK:- App Coordinator Did finish
extension AppCoordinatorTests: AppCoordinatorDelegate {
    func appCoordinatorDidFinish(_ coordinator: AppCoordinator) {
        callDidFinish?.fulfill()
    }
}
