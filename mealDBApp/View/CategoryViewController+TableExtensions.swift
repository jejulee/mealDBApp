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
        if let imgUrlExists = meal.image {
            loadImage(cell, imgUrlExists, mealID: meal.id!)
        }
        
        return cell
    }
    
    // TODO: this is only temporary
    private func loadImage(_ cell: MealViewCell, _ url: URL, mealID: String) {
        if !mealUIImages.keys.contains(mealID) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.mealUIImages[mealID] = UIImage(data: data)
                        cell.image = self.mealUIImages[mealID]
                    }
                }
            }
        } else {
            cell.image = mealUIImages[mealID]
        }
        
    }

}

extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // when selected
        print(categoryListVM?.getMeal(indexPath.row))
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
