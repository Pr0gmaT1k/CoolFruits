//
//  Navigator.swift
//  weapp-ios
//
//  Created by azerty on 13/06/2020.
//  Copyright © 2020 azerty. All rights reserved.
//

import UIKit

// *******************************
// MARK: - NavDelegate
// *******************************
protocol NavDelegate: AnyObject {
    func push(vc: UIViewController, animated: Bool)
    func pop(animated: Bool)
}

// *******************************
// MARK: - NavigatorType
// *******************************

///  Defines a proxy for a `UINavigationController`, providing a
///  a completion handler for when controllers are popped from the stack.
///
///  For a concrete instance, use a `Navigator`.

protocol NavigatorType {
    
    /** Pops all the view controllers on the stack except the root view controller and updates the display. */
    @discardableResult
    func popToRootViewController(animated: Bool) -> [UIViewController]?

    /** Pops view controllers until the specified view controller is at the top of the navigation stack. */
    @discardableResult
    func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]?
    
    /** Pops the top view controller from the navigation stack and updates the display. */
    @discardableResult
    func popViewController(animated: Bool) -> UIViewController?
    
    /** Pushes a view controller onto the receiver’s stack and updates the display. */
    func push(_ viewController: UIViewController, animated: Bool, onPoppedCompletion: (() -> Void)?)
    
    /** Replaces all the view controllers currently managed by the navigation controller a new root view controller. */
    func setRootViewController(_ viewController: UIViewController, animated: Bool)

    var navigationController: UINavigationController { get }

    var delegate: NavDelegate? { get set }
}

extension NavigatorType {

    func push(_ viewController: UIViewController, animated: Bool) {
        push(viewController, animated: animated, onPoppedCompletion: nil)
    }

}

// *******************************
// MARK: - Navigator
// *******************************

///  `Navigator` is a proxy object for a `UINavigationController`.
///  Unlike a regular `UINavigationController`, however, it provide a completion handler
///  for when its `UIViewContoller`s are popped from the navigation stack.

final class Navigator: NSObject, NavigatorType {
    weak var delegate: NavDelegate?
    var navigationController: UINavigationController
    private var completions: [UIViewController: () -> Void]
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        self.completions = [:]
        
        super.init()
        
        self.navigationController.delegate = self
    }
    
}

// MARK: - Navigation methods

extension Navigator {
    
    func popToRootViewController(animated: Bool) -> [UIViewController]? {
        let poppedControllers = navigationController.popToRootViewController(animated: animated)
        return poppedControllers
    }
    
    func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        let poppedControllers = navigationController.popToViewController(viewController, animated: animated)
        return poppedControllers
    }
    
    func popViewController(animated: Bool) -> UIViewController? {
        delegate?.pop(animated: animated)
        if let poppedController = navigationController.popViewController(animated: animated) {
            runCompletion(for: poppedController)
            return poppedController
        }
        return nil
    }

    func push(_ viewController: UIViewController, animated: Bool, onPoppedCompletion: (() -> Void)? = nil) {
        delegate?.push(vc: viewController, animated: animated)
        if let completion = onPoppedCompletion {
            completions[viewController] = completion
        }
        
        navigationController.pushViewController(viewController, animated: animated)
    }

    func setRootViewController(_ viewController: UIViewController, animated: Bool) {
        completions = [:]
        navigationController.setViewControllers([viewController], animated: animated)
    }

}

// MARK: - UINavigationControllerDelegate

extension Navigator: UINavigationControllerDelegate {
    
    // Runs completion handler when a user swipes-to-go-back or taps the back button in the navigation bar.
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let poppingViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(poppingViewController) else {
                return
        }
        
        runCompletion(for: poppingViewController)
    }
    
}

// MARK: - Helpers

private extension Navigator {
    
    func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
    
}
