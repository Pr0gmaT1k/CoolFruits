//
//  FruitsListPresenter.swift
//  CoolFruits
//
//  Created by AzerTy on 01/04/2023.
//

import UIKit
import Reusable

// MARK: - Presentable
protocol FruitsListPresentable: UITableViewDataSource {
    var fruits: [FruitModel]? { get set }
    init(view: FruitsListDisplayable)
    func refreshFruitsList()
}

// MARK: - Presenter
final class FruitsListPresenter: NSObject, FruitsListPresentable {
    // MARK: - Properties
    internal var fruits: [FruitModel]?
    private weak var displayable: FruitsListDisplayable?
    
    // MARK: - funcs
    init(view: FruitsListDisplayable) {
        displayable = view
        view.fruitsTableView.register(cellType: FruitCell.self)
    }
    
    func refreshFruitsList() {
        RequestManager.shared.getAllFruts { [weak self] fruits, error in
            self?.fruits = fruits
            DispatchQueue.main.async { [weak self] in
                self?.displayable?.fruitsTableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension FruitsListPresenter {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as FruitCell
        cell.fill(fruit: fruits?[indexPath.row])
        return cell
    }
}
