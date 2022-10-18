//
//  mealQuery.swift
//  mealDBApp
//
//  Created by Jeanie Lee on 10/13/22.
//

import Foundation

enum FilterType{
    case category(_ mealCategory: String)
    // can add other filter types: area, main ingredient, multi-ingred
}

enum MealQuery {
    case filterBy(FilterType)
    case lookupByID(id: String)
    
    var base: String {
        return "https://www.themealdb.com/api/json/v1/1/"
    }
    
    var path: String {
        switch self {
        case .filterBy:
            return "filter.php?"
        case .lookupByID:
            return "lookup.php?"
        }
    }
    
    var query: String {
        switch self {
        case .filterBy(.category(let mealCategory)):
            return "c=\(mealCategory)"
        case .lookupByID(let id):
            return "i=\(id)"
        }
    }
    
}
