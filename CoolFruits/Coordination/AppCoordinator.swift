//
//  AppCoordinator.swift
//  Newspaper
//
//  Created by azerty on 04/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import UIKit

// MARK: - Delegate
protocol AppCoordinatorDelegate: AnyObject {
    func appCoordinatorDidFinish(_ coordinator: AppCoordinator)
}

/** The application's root `Coordinator`. */
final class AppCoordinator: CoordinatorPresentable {
    // MARK: - Properties
    weak var delegate: AppCoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var rootViewController = UIViewController()
    
    // MARK: - Funcs
    init(window: UIWindow) {
        self.rootViewController.view.backgroundColor = .white
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    func start() {
        let coordinator = FruitsCoordinator()
        coordinator.delegate = self
        presentCoordinator(coordinator, animated: false)
        coordinator.start()
    }
}

// MARK: - FruitsList Coordinator Delegate
extension AppCoordinator: FruitsCoordinatorDelegate {
    func fruitsListCoordinatorDidFinish(_ coordinator: FruitsCoordinator) {
        removeChildCoordinator(coordinator)
        delegate?.appCoordinatorDidFinish(self)
    }
}
