//
//  FruitCell.swift
//  CoolFruits
//
//  Created by Luis Alejandro Zapata Gonzalez on 19-07-22.
//

import Foundation
import UIKit

public class FruitCell: UITableViewCell {
    @IBOutlet weak var fruitNameLabel: UILabel!
    @IBOutlet weak var fruitSugarLabel: UILabel!
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setUp(fruitName: String?, fruitSugar: Double?, isCitrus: Bool) {
        guard let fruitName = fruitName else {
            return
        }

        guard let fruitSugar = fruitSugar else {
            return
        }

        fruitNameLabel.text = "\(isCitrus ? " * " : "") \(fruitName)"
        fruitSugarLabel.text = "(Sugar:" + String(fruitSugar) + ")"
    }
    
    class func createCell() -> FruitCell? {
        let nib = UINib(nibName: "FruitCell", bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil).last as? FruitCell
        return cell
    }
}
