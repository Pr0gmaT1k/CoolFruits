//
//  FruitsListCoordinator.swift
//  CoolFruits
//
//  Created by AzerTy on 01/04/2023.
//

import UIKit

// MARK: - Delegate
protocol FruitsCoordinatorDelegate: AnyObject {
    func fruitsListCoordinatorDidFinish(_ coordinator: FruitsCoordinator)
}

// MARK: - Coordinator
final class FruitsCoordinator: CoordinatorPresentable {
    // MARK: - Properties
    weak var delegate: FruitsCoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var rootViewController: FruitsListVC

    // MARK: - funcs
    init() {
        rootViewController = FruitsListVC()
        rootViewController.modalPresentationStyle = .fullScreen
        rootViewController.modalTransitionStyle = .crossDissolve
        rootViewController.delegate = self
    }

    func start() {}
}

// MARK: - FruitslistVC Delegate
extension FruitsCoordinator: FruitsListVCDelegate {
    func didSelect(fruit: FruitModel, animated: Bool) {
        let vc = FruitDetailsVC()
        vc.fruit = fruit
        rootViewController.present(vc, animated: animated)
    }
}
