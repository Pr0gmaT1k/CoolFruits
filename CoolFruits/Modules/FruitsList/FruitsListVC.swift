//
//  FruitsListVCViewController.swift
//  CoolFruits
//
//  Created by AzerTy on 01/04/2023.
//

import UIKit

// MARK: - ViewModel
public class HomeViewModel {
    var fruits: [FruitModel?]?
}

// MARK: - Delegate
protocol FruitsListVCDelegate: AnyObject {
    func didSelect(fruit: FruitModel)
}

// MARK: - Class
class FruitsListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: - IBOutlets
    @IBOutlet weak var fruitsTableView: UITableView!
    
    // MARK: - Properties
    var viewModel: HomeViewModel = HomeViewModel()
    weak var delegate: FruitsListVCDelegate?
    
    // MARK: - funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.fruitsTableView.register(UINib.init(nibName: "CounterCellView", bundle: nil), forCellReuseIdentifier: "counterCell")
        self.fruitsTableView.delegate = self
        self.fruitsTableView.dataSource = self
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.topItem?.title = "Fruitspedia"
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        RequestManager.shared.getAllFruts { fruits, error in
            self.viewModel.fruits = fruits
            DispatchQueue.main.async {
                self.fruitsTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.fruits?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "FruitCell") as? FruitCell
        
        if cell == nil {
            cell = FruitCell.createCell()
        }
        cell!.setUp(fruitName: viewModel.fruits?[indexPath.row]?.name, fruitSugar: viewModel.fruits?[indexPath.row]?.nutritions?.sugar, isCitrus: viewModel.fruits?[indexPath.row]?.genus == "Citrus")
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let fruit = viewModel.fruits?[indexPath.row] else { return }
        delegate?.didSelect(fruit: fruit)
    }
}
