//
//  MainController.swift
//  mealDBApp
//
//  Created by Jeanie Lee on 10/17/22.
//

import Foundation
import UIKit

class MainController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isNavigationBarHidden = true
        let catVC = CategoryViewController()
        catVC.categoryName = "Dessert"
        self.pushViewController(catVC, animated: true)
    }
}
