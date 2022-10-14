//
//  MealsDBFetch.swift
//  mealDBApp
//
//  Created by Jeanie Lee on 10/13/22.
//

import Foundation

class MealsDBFetch {
    
    func loadData(get: MealQuery, completion: @escaping (_ meals: [MealItem])->Void) {
        guard let url = URL(string: get.base + get.path + get.query) else {
            print ("Invalid Query")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("There was an error")
                print(error)
            }
            do {
                if let jsonData = data {
                    let mealsData = try JSONDecoder().decode(MealList<MealItem>.self, from: jsonData)
                    completion(mealsData.meals)
                }
            } catch {
                print (error)
            }
        }
        
        task.resume()
    }
}
