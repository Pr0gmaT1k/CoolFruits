//
//  FruitsListPresenter.swift
//  CoolFruits
//
//  Created by AzerTy on 01/04/2023.
//

import UIKit

// MARK: - Presentable
protocol FruitsListPresentable {
    // MARK: - Funcs
    init(view: FruitsListDisplayable)
    func refreshFruitsList()
}

// MARK: - Presenter
struct FruitsListPresenter: FruitsListPresentable {
    // MARK: - Properties
    private weak var displayable: FruitsListDisplayable?
    
    // MARK: - funcs
    init(view: FruitsListDisplayable) {
        displayable = view
    }
    
    func refreshFruitsList() {
        RequestManager.shared.getAllFruts { fruits, error in
            displayable?.fruits = fruits
            DispatchQueue.main.async {
                self.displayable?.fruitsTableView.reloadData()
            }
        }
    }
}
