//
//  CategoryListViewModel.swift
//  mealDBApp
//
//  Created by Jeanie Lee on 10/13/22.
//

import Foundation
import UIKit
protocol CategoryListViewModelDelegate {
    func reloadMeals()
}

protocol MealDetailsDelegate {
    func loadDetails(_ mealDetail: MealDetail)
}

class CategoryListViewModel {
    private var meals = [MealItem]()
    
    var categoryListDelegate: CategoryListViewModelDelegate?
    var mealDetailDelegate: MealDetailsDelegate?
    
    var category: String
    
    private let mealsClient: MealsDBFetch
    
    // List of mealIndices that signify their image has been downloaded already
    private var tasksHist: [Int] = []
    
    init(categoryName: String) {
        self.category = categoryName
        mealsClient = MealsDBFetch()
        loadMealsDB()
    }
    
    // Fetch all mealData
    private func loadMealsDB() {
        mealsClient.loadMealsData(from: .filterBy(.category(category))){ [weak self] manyMeals in
            self?.meals = manyMeals
            self?.categoryListDelegate?.reloadMeals()
        }
    }
    
    func count() -> Int {
        return meals.count
    }

    func getMeal(_ atIndex: Int) -> MealItem {
        return meals[atIndex]
    }
    
    // Load Meal Details and tell Delegate that meal details have been populated
    func loadMealDetails(_ atIndex: Int){
        let meal = meals[atIndex]
        // Check if mealDetails existed
        if let mealDetail = meal.mealDetail{
            self.mealDetailDelegate?.loadDetails(mealDetail)
        } else {
            // Fetch mealDetails from DB
            guard let id = meal.id else {return}
            
            mealsClient.loadMealDetail(from: .lookupByID(id: id), completion: {[weak self] mealDetail in
                self?.meals[atIndex].mealDetail = mealDetail
                self?.mealDetailDelegate?.loadDetails(mealDetail)
            })
        }
    }
    
    // Download image data if image hasn't been loaded ever
    func fetchImageData(_ index: Int, _ url: URL, completion: @escaping (_ data: Data) -> Void) {
        if !tasksHist.contains(index) {
            tasksHist.append(index)
            let task = URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
                guard let data = data, error == nil else { return }
                
                completion(data)
            }
            task.resume()
        }
    }
    
}
