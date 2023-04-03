//
//  FruitCell.swift
//  CoolFruits
//
//  Created by Luis Alejandro Zapata Gonzalez on 19-07-22.
//

import UIKit
import Reusable

// MARK: - Class
final class FruitCell: UITableViewCell, NibReusable {
    // MARK: - IBOutlets
    @IBOutlet weak var fruitNameLabel: UILabel!
    @IBOutlet weak var fruitSugarLabel: UILabel!
    
    // MARK: - funcs
    public func fill(fruit: FruitModel?) {
        guard let fruit = fruit,
        let name = fruit.name,
        let sugar = fruit.nutritions?.sugar else { return }
        fruitNameLabel.text = name
        fruitSugarLabel.text = "(Sugar:" + String(sugar) + ")"
    }
}
