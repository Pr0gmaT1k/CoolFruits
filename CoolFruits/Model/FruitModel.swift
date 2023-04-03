//
//  FruitModel.swift
//  CoolFruits
//
//  Created by Luis Alejandro Zapata Gonzalez on 19-07-22.
//

import Foundation

struct FruitModel: Codable {
    var genus, name, family, order: String?
    var id: Int?
    var nutritions: NutritionsModel?
}

struct NutritionsModel: Codable {
    var sugar, carbohydrates, protein, fat: Double?
    var calories: Int?
}
