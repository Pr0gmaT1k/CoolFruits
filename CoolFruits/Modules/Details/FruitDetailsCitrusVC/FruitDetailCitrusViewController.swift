//
//  FruitDetailCitrusViewController.swift
//  CoolFruits
//
//  Created by Luis Alejandro Zapata Gonzalez on 21-07-22.
//

import UIKit

public class FruitDetailCitrusViewController: UIViewController {
    @IBOutlet weak var familyLabel: UILabel!
    @IBOutlet weak var genusLabel: UILabel!
    @IBOutlet weak var nutritionLabel: UILabel!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        familyLabel.text = "Family: \(SelectedFruit.fruit!.family!)"
        genusLabel.text = "Genus: \(SelectedFruit.fruit!.genus!)"
        nutritionLabel.text = getNutritionText(selectedFruit: SelectedFruit.fruit!)
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
