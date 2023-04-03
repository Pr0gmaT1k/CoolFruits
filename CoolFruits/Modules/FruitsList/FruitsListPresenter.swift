//
//  FruitsListPresenter.swift
//  CoolFruits
//
//  Created by AzerTy on 01/04/2023.
//

import UIKit
import Reusable

// MARK: - Presentable
protocol FruitsListPresentable: UITableViewDataSource, UISearchBarDelegate {
    var fruits: [FruitModel]? { get set }
    var displayedFruits: [FruitModel]? { get set }
    init(view: FruitsListDisplayable)
    func refreshFruitsList()
}

// MARK: - Presenter
final class FruitsListPresenter: NSObject, FruitsListPresentable {
    // MARK: - Properties
    internal var fruits: [FruitModel]?
    internal var displayedFruits: [FruitModel]?
    private weak var displayable: FruitsListDisplayable?
    
    // MARK: - funcs
    init(view: FruitsListDisplayable) {
        displayable = view
        view.fruitsTableView.register(cellType: FruitCell.self)
    }
    
    func refreshFruitsList() {
        displayable?.showLoader()
        RequestManager.shared.getAllFruts { [weak self] fruits, error in
            self?.displayable?.hideLoader(animated: true, completion: nil)
            self?.fruits = fruits
            self?.displayedFruits = fruits
            DispatchQueue.main.async { [weak self] in
                self?.displayable?.fruitsTableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension FruitsListPresenter {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedFruits?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as FruitCell
        cell.fill(fruit: displayedFruits?[indexPath.row])
        return cell
    }
}

// MARK: - Search Bar Delegate
extension FruitsListPresenter: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        displayedFruits = searchText.isEmpty ? fruits : fruits?.filter { $0.name?.range(of: searchText, options: .caseInsensitive) != nil }
        displayable?.fruitsTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.endEditing(true)
        displayedFruits = fruits
        displayable?.fruitsTableView.reloadData()
    }
}
