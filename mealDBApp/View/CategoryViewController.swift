//
//  ViewController.swift
//  mealDBApp
//
//  Created by Jeanie Lee on 10/12/22.
//

import UIKit

class CategoryViewController: UIViewController {
    var categoryName: String?
    
    var categoryListVM: CategoryListViewModel?
    
    // Table to show all meals
    let mealsView: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // This will show Category Name
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
    
    // Array of images that have been downloaded, with its mealName as key
    lazy var mealUIImages = [String:UIImage]()
    
    private lazy var loadView: UIActivityIndicatorView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(mealsView)
        setupVM()
        setupTableView()
        
        startLoad()
    }
    
    // Setup ViewModel and inject dependencies
    private func setupVM() {
        categoryListVM = CategoryListViewModel(categoryName: categoryName ?? "Dessert")
        categoryListVM?.categoryListDelegate = self
        categoryName = categoryListVM?.category
    }

    // Setup Table for our meals
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
    
    // Begin Loading Icon while we fetch data
    private func startLoad() {
        self.view.addSubview(loadView)
        loadView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loadView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        loadView.startAnimating()
    }
}

extension CategoryViewController: CategoryListViewModelDelegate {
    
    // Called once data is fetched
    func reloadMeals() {
        DispatchQueue.main.async {
            self.loadView.stopAnimating()
            self.mealsView.reloadData()
        }
    }
}
