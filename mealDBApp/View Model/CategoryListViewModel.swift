//
//  CategoryListViewModel.swift
//  mealDBApp
//
//  Created by Jeanie Lee on 10/13/22.
//

import Foundation
protocol CategoryListViewModelDelegate {
    func loadMeals()
}

class CategoryListViewModel {
    private var meals = [MealItem]()
    
    var delegate: CategoryListViewModelDelegate?
    
    private let mealsClient: MealsDBFetch
    
    init() {
        mealsClient = MealsDBFetch()
        mealsClient.loadData(get: .filterBy(.category(mealCategory: "Dessert"))){ [weak self] manyMeals in
            self?.meals = manyMeals
            self?.delegate?.loadMeals()
        }
    }
    
    func count() -> Int {
        return meals.count
    }

    func getMeal(_ atIndex: Int) -> MealItem {
        return meals[atIndex]
    }
    
}
