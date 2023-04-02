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
protocol FruitsListDisplayable: AnyObject {
    var fruits: [FruitModel]? { get set }
    var fruitsTableView: UITableView! { get set }
}

// MARK: - Class
class FruitsListVC: UIViewController, FruitsListDisplayable, UITableViewDataSource, UITableViewDelegate {
    // MARK: - IBOutlets
    @IBOutlet weak var fruitsTableView: UITableView!
    
    // MARK: - Properties
    var fruits: [FruitModel]?
    weak var delegate: FruitsListVCDelegate?
    lazy var presenter: FruitsListPresentable = FruitsListPresenter(view: self)
    
    // MARK: - funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.fruitsTableView.register(UINib.init(nibName: "CounterCellView", bundle: nil), forCellReuseIdentifier: "counterCell")
        self.fruitsTableView.delegate = self
        self.fruitsTableView.dataSource = self
        self.presenter.refreshFruitsList()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "FruitCell") as? FruitCell
        if cell == nil {
            cell = FruitCell.createCell()
        }
        cell!.setUp(fruitName: fruits?[indexPath.row].name, fruitSugar: fruits?[indexPath.row].nutritions?.sugar, isCitrus: fruits?[indexPath.row].genus == "Citrus")
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let fruit = fruits?[indexPath.row] else { return }
        delegate?.didSelect(fruit: fruit)
    }
}
