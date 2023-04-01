//
//  FruitDetailsVC.swift
//  CoolFruits
//
//  Created by AzerTy on 01/04/2023.
//

import UIKit

// MARK: - VC
final class FruitDetailsVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var familyLabel: UILabel!
    @IBOutlet weak var genusLabel: UILabel!
    @IBOutlet weak var nutritionLabel: UILabel!
    
    // MARK: - Properties
    var fruit: FruitModel?
    
    // MARK: - Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let fruit = self.fruit else { return }
        fill(fruit: fruit)
    }
    
    func fill(fruit: FruitModel) {
        familyLabel.text = "Family: \(fruit.family!)"
        genusLabel.text = "Genus: \(fruit.genus!)"
        nutritionLabel.text = getNutritionText(selectedFruit: fruit)
        view.backgroundColor = fruit.genus == "Citrus" ? .green : .white
    }
    
    func getNutritionText(selectedFruit: FruitModel) -> String {
        var text = String()
        text += "Sugar: " + String(selectedFruit.nutritions?.sugar ?? 0)
        text += "\n"
        text += "Calories: " + String(selectedFruit.nutritions?.calories ?? 0)
        text += "\n"
        text += "Fat: " + String(selectedFruit.nutritions?.fat ?? 0)
        return text
    }
}
