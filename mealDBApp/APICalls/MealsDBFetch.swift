//
//  MealsDBFetch.swift
//  mealDBApp
//
//  Created by Jeanie Lee on 10/13/22.
//

import Foundation

class MealsDBFetch {
    
    // Pull JSON Data from URL
    private func requestData(from url: URL, completion: @escaping (Data)->Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("There was an error")
                print(error)
            }
            
            if let jsonData = data {
                completion(jsonData)
            }
        }
        task.resume()
    }
    
    
    // Load Basic Meal Item from JSON Data, directly map to MealItem Struct
    func loadMealsData(from get: MealQuery, completion: @escaping (_ meals: [MealItem])->Void) {
        guard let url =  URL(string: get.base + get.path + get.query) else {
            print ("Invalid Query")
            return
        }
        requestData(from: url) { jsonData in
            do {
                let mealsData = try JSONDecoder().decode(MealList<MealItem>.self, from: jsonData)
                completion(mealsData.meals)
            } catch {
                print("Failed decoding JSON Data")
            }
        }
    }
    
    // Load Meal Details from pulled JSON Data
    func loadMealDetail(from get: MealQuery, completion: @escaping(_ meal: MealDetail)->Void) {
        guard let url =  URL(string: get.base + get.path + get.query) else {
            print ("Invalid Query")
            return
        }
        requestData(from: url) { [weak self] jsonData in
            do {
                if let jsonData: [String:Any] = try (JSONSerialization.jsonObject(with: jsonData) as? [String : Any]) {
                    if let meal = self?.cleanData(jsonData) {
                        completion(meal)
                    }
                    
                }
            } catch {
                print("Failed decoding JSON Data")
            }
        }
    }
    
    
    // Clean the meal Ingredients/Measurements and Instructions Data
    func cleanData(_ json: [String:Any]) -> MealDetail? {
        guard let outerDict = json["meals"] as? [Any] else {
            print("Error parsing jsonData: no meals")
            return nil
        }
        
        guard let mealData = outerDict[0] as? [String:Any] else {
            print("No meal exists in meals Dictionary")
            return nil
        }
        
        var mealInstructions: [String]?
        if let inst = mealData["strInstructions"] as? String {
            var getInstructions = inst.split(whereSeparator: \.isNewline)
            mealInstructions = getInstructions.map{instr in
                return String(instr)}
        }
        
        var mealIngredients: [String: (ingredient: String?, measure: String?)] = [:]
        for (key,value) in mealData {
            let strIng = "strIngredient"
            let strMea = "strMeasure"
            
            guard let value = value as? String else {continue}
            let validValue = !value.trimmingCharacters(in: .whitespaces).isEmpty
            var newKey = key
            if newKey.hasPrefix(strIng) && validValue {
                newKey = String(newKey.dropFirst(strIng.count))
                mealIngredients[newKey, default: (nil,nil)].ingredient = value
            } else if newKey.hasPrefix(strMea) && validValue{
                newKey = String(newKey.dropFirst(strMea.count))
                mealIngredients[newKey, default: (nil,nil)].measure = value
            }
        }
        
        if mealIngredients.isEmpty && mealInstructions == nil {
            return nil
        }
        
            
        var mealIngredientsAndMeasures: [(String?, String?)]?
        if !mealIngredients.isEmpty {
            mealIngredientsAndMeasures = Array(mealIngredients.values)
        }
        
        return MealDetail(instructions: mealInstructions, ingredientsAndMeasures: mealIngredientsAndMeasures)
    }
    
}
