//
//  ViewController.swift
//  mealDBApp
//
//  Created by Jeanie Lee on 10/12/22.
//

import UIKit

class CategoryViewController: UIViewController {
    var categoryName: String?
    
    private let mealsView: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var headerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))
        
        let label = UILabel()
        label.text = categoryName ?? ""
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        return view
    }()
    
    lazy var mealUIImages = [String:UIImage]()
    
    var categoryListVM: CategoryListViewModel? = CategoryListViewModel()

    override func viewDidLoad() {
        categoryListVM?.delegate = self
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(mealsView)
        setupTableView()
    }

    private func setupTableView() {
        mealsView.tableHeaderView = headerView
        
        NSLayoutConstraint.activate([
            mealsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mealsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mealsView.widthAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            mealsView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])

        mealsView.separatorStyle = .none
        mealsView.tableHeaderView = headerView

        mealsView.register(MealViewCell.self, forCellReuseIdentifier:"MealViewCell")
        mealsView.dataSource = self
        mealsView.delegate = self
    }
}

extension CategoryViewController: CategoryListViewModelDelegate {
    func loadMeals() {
        DispatchQueue.main.async {
            self.mealsView.reloadData()
        }
    }
}
