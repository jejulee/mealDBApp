//
//  mealItemModel.swift
//  mealDBApp
//
//  Created by Jeanie Lee on 10/13/22.
//
import Foundation

struct MealItem: Decodable {
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case image = "strMealThumb"
        case id = "idMeal"
    }
    let name: String?
    let id: String?
    let image: URL?
}

struct MealList<T: Decodable>: Decodable {
    let meals: [MealItem]
}
