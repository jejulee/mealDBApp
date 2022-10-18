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
    
    let mealsView: UITableView = {
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
    let loadView: UIActivityIndicatorView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        view.addSubview(mealsView)
        setupVM()
        setupTableView()
        
        startLoad()
    }
    
    private func startLoad() {
        self.view.addSubview(loadView)
        loadView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loadView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        loadView.startAnimating()
    }
    
    private func setupVM() {
        categoryListVM = CategoryListViewModel(categoryName: categoryName ?? "Dessert")
        categoryListVM?.categoryListDelegate = self
        categoryName = categoryListVM?.category
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
    func reloadMeals() {
        DispatchQueue.main.async {
            self.loadView.stopAnimating()
            self.mealsView.reloadData()
        }
    }
}
