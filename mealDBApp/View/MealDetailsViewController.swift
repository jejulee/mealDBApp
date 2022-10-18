//
//  MealDetailsViewController.swift
//  mealDBApp
//
//  Created by Jeanie Lee on 10/14/22.
//

import Foundation
import UIKit

class MealDetailsViewController: UIViewController {
    var name: String?
    var image: UIImage?
    
    let scrollView = UIScrollView()
    
    lazy var ingrTitle = createTitle("Ingredients")
    lazy var instrTitle = createTitle("Instructions")
    
    // Meal Name View
    lazy var nameTitle: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))
        let label = UILabel()
        label.text = name?.uppercased() ?? "Meal Name Unavailable"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = 300
        view.addSubview(label)
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        return label
    }()
    
    lazy var imageView: UIImageView? = {
        if let image = image {
            let imageView = UIImageView(frame: .zero)
            imageView.image = image
            imageView.layer.cornerRadius = 36
            imageView.layer.masksToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFill
            imageView.alpha = 0.5
            imageView.clipsToBounds = true
            return imageView
        }
        return nil
    }()
    
    lazy var mealIngrAndMeas: IngredientsAndMeasuresView = {
        let view = IngredientsAndMeasuresView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let mealInstr: InstructionsView = {
        let view = InstructionsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupScrolling()
        self.addNameAndImage()
        self.addIngrAndMeas()
        self.addInstr()
    }
    
    func setupScrolling() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        self.scrollView.isUserInteractionEnabled = true
        self.scrollView.isScrollEnabled = true
        
        self.view.addSubview(scrollView)
        
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    func addNameAndImage() {
        self.scrollView.addSubview(nameTitle)
        
        NSLayoutConstraint.activate([
            nameTitle.topAnchor.constraint(equalTo: scrollView.topAnchor),
            nameTitle.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            nameTitle.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // Only add Image if it exists
        if let imageView = imageView{
            self.scrollView.addSubview(imageView)
            self.scrollView.sendSubviewToBack(imageView)
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                imageView.heightAnchor.constraint(equalToConstant: 250)
            ])
            
            nameTitle.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        }
    }
    
    func addIngrAndMeas() {
        self.scrollView.addSubview(ingrTitle)
        
        NSLayoutConstraint.activate([
            ingrTitle.topAnchor.constraint(equalTo: nameTitle.bottomAnchor, constant: 10),
            ingrTitle.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            ingrTitle.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        self.scrollView.addSubview(mealIngrAndMeas)
        
        NSLayoutConstraint.activate([
            mealIngrAndMeas.topAnchor.constraint(equalTo: ingrTitle.bottomAnchor),
            mealIngrAndMeas.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            mealIngrAndMeas.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func addInstr() {
        self.scrollView.addSubview(instrTitle)
        
        NSLayoutConstraint.activate([
            instrTitle.topAnchor.constraint(equalTo: mealIngrAndMeas.bottomAnchor, constant: 10),
            instrTitle.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            instrTitle.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        self.scrollView.addSubview(mealInstr)
        
        NSLayoutConstraint.activate([
            mealInstr.topAnchor.constraint(equalTo: instrTitle.bottomAnchor),
            mealInstr.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            mealInstr.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            mealInstr.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    // Return a titleView
    func createTitle(_ text: String) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        return label
    }
}

extension MealDetailsViewController: MealDetailsDelegate {
    
    // Called when we receive the mealDetails
    func loadDetails(_ mealDetail: MealDetail) {
        DispatchQueue.main.async {
            self.mealInstr.load(mealDetail.instructions)
            self.mealIngrAndMeas.load(mealDetail.ingredientsAndMeasures)
        }
    }
}
