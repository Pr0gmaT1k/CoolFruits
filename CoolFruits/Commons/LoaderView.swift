//
//  LoaderView.swift
//  CoolFruits
//
//  Created by AzerTy on 03/04/2023.
//

import UIKit

/// A simple loader view. Integrated in UIViewController with showNPLoader: & hideNPLoader:
final class LoaderView: UIView {
    override init(frame: CGRect) {
        let center = CGPoint(x: frame.size.width  / 2,
        y: frame.size.height / 2)
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(origin: center, size: CGSize(width: 30, height: 30)))
        super.init(frame: frame)
        self.backgroundColor = .systemGray.withAlphaComponent(0.5)
        self.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        self.alpha = 0
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    /// Fade in
    func show() {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 1.0
        })
    }
    
    /// Fade out
    public func hide(animated: Bool = true, completion: (() -> Void)? = nil) {
        if animated {
            UIView.animate(withDuration: 0.5, animations: {
                self.alpha = 0.0
            }, completion: { _ in
                self.removeFromSuperview()
                completion?()
            })
        } else {
            self.alpha = 0.0
            self.removeFromSuperview()
        }
    }
}

// MARK: - Loadable
protocol Loadable: AnyObject {
    func showLoader()
    func hideLoader(animated: Bool, completion: (() -> Void)?)
    var loaderIsShown: Bool { get }
}

// MARK: - Add default management to UIVC
extension UIViewController: Loadable {
    /// Fade in
    func showLoader() {
        let loader = LoaderView(frame: self.view.frame)
        self.view.addSubview(loader)
        loader.show()
    }

    var loaderIsShown: Bool {
        return self.view.subviews.filter { $0 is LoaderView }.isEmpty == false
    }
    
    /// Fade out
    func hideLoader(animated: Bool = true, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async { [weak self] in
            let loaderViews = self?.view.subviews.filter { $0 is LoaderView } as? [LoaderView]
            _ = loaderViews?.compactMap { $0.hide(animated: animated, completion: completion) }
        }
    }
}
