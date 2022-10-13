//
//  ViewController.swift
//  mealDBApp
//
//  Created by Jeanie Lee on 10/12/22.
//

import UIKit

class CategoryViewController: UIViewController {
    private let mealsView: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    lazy var headerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))
        
        let label = UILabel()
        label.text = "Desserts"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
       
        view.addSubview(label)
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        return view
    }()
    
    let dummyData = [
        mealItem(name: "spaghetti", id: 0, image: "https://www.onceuponachef.com/images/2019/09/Spaghetti-and-Meatballs.jpg"),
        mealItem(name: "spa2", id: 1, image: "https://www.themealdb.com//images//media//meals//adxcbq1619787919.jpg"),
        mealItem(name: "spa3", id: 2, image: "https://www.onceuponachef.com/images/2019/09/Spaghetti-and-Meatballs.jpg")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(mealsView)
        mealsView.tableHeaderView = headerView
        addTableConstraints()
    }

    private func addTableConstraints() {
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

extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealViewCell", for: indexPath) as! MealViewCell
        let meal = dummyData[indexPath.row]
        cell.name = meal.name!
        if let imgUrlExists = meal.image {
            loadImage(cell, imgUrlExists)
        }
        

        return cell
    }
    
    private func loadImage(_ cell: MealViewCell, _ urlStr: String) {
        if let url = URL(string: urlStr) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        print("hello")
                        cell.image = UIImage(data: data)
                    }
                }
            }
        }
    }

}

extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // when selected
        print(dummyData[indexPath.row])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

