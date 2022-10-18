//
//  CategoryViewController+TableExtensions.swift
//  mealDBApp
//
//  Created by Jeanie Lee on 10/13/22.
//

import Foundation
import UIKit

extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryListVM?.count() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealViewCell", for: indexPath) as! MealViewCell
        guard let meal = categoryListVM?.getMeal(indexPath.row) else {return cell}
        cell.name = meal.name!
        
        guard let url = meal.image else {return cell}
        if !mealUIImages.keys.contains(meal.name ?? "") {
            let data = categoryListVM?.fetchImageData(indexPath.row, url){data in
                DispatchQueue.main.async() {[weak self] in
                    self?.mealUIImages[meal.name!] = UIImage(data: data)
                    self?.mealsView.reloadRows(at: [indexPath], with: .fade)
                }
            }
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! MealViewCell
        if mealUIImages.keys.contains(cell.name ?? "") {
            cell.image = self.mealUIImages[cell.name!]
        }
        
        func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            let cell = cell as! MealViewCell
            cell.image = nil
        }
    }
}

extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // when selected
        guard let meal = categoryListVM?.getMeal(indexPath.row) else {return}
        let window = MealDetailsViewController()
        window.name = meal.name
        if let mealName = meal.name {
            if mealUIImages.keys.contains(mealName) {
                window.image = mealUIImages[mealName]
            }
        }
        categoryListVM?.mealDetailDelegate = window
        categoryListVM?.loadMealDetails(indexPath.row)
        self.present(window, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
