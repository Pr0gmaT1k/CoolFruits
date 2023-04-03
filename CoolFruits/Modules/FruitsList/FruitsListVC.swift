//
//  FruitsListVCViewController.swift
//  CoolFruits
//
//  Created by AzerTy on 01/04/2023.
//

import UIKit

// MARK: - Delegate
protocol FruitsListVCDelegate: AnyObject {
    func didSelect(fruit: FruitModel)
}

// MARK: - Displayable
protocol FruitsListDisplayable: Loadable {
    var fruitsTableView: UITableView! { get set }
}

// MARK: - Class
class FruitsListVC: UIViewController, FruitsListDisplayable {
    // MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var fruitsTableView: UITableView!
    
    // MARK: - Properties
    weak var delegate: FruitsListVCDelegate?
    lazy var presenter: FruitsListPresentable = FruitsListPresenter(view: self)
    
    // MARK: - funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = presenter
        fruitsTableView.delegate = self
        fruitsTableView.dataSource = presenter
        fruitsTableView.keyboardDismissMode = .onDrag
        presenter.refreshFruitsList()
    }
}

// MARK: - UITableViewDelegate
extension FruitsListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let fruit = presenter.fruits?[indexPath.row] else { return }
        delegate?.didSelect(fruit: fruit)
    }
}
