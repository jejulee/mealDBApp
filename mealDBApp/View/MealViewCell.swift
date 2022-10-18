//
//  CardView.swift
//  mealDBApp
//
//  Created by Jeanie Lee on 10/12/22.
//

import Foundation
import UIKit

class MealViewCell: UITableViewCell {
    var image: UIImage? {
        didSet {
            addImageView()
        }
    }
    var name: String? {
        didSet {
            addNameView()
        }
    }
    
    private var container: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var imgView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = image
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()

    private lazy var nameView: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = self.name
        label.numberOfLines = 2
        //label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(container)
        self.container.addSubview(nameView)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1)
        ])
        
        
        NSLayoutConstraint.activate([
            nameView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            nameView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameView.trailingAnchor.constraint(lessThanOrEqualTo: self.container.trailingAnchor, constant: -10)
        ])
    }
    
    private func addImageView() {
        imgView.image = image
        imgView.alpha = 0.0
        UIView.animate(withDuration: 0.5) {
            self.imgView.alpha = 0.5
        }
        self.container.addSubview(imgView)
        self.container.sendSubviewToBack(imgView)
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: container.topAnchor),
            imgView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            imgView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            imgView.bottomAnchor.constraint(lessThanOrEqualTo: container.bottomAnchor)
        ])
    }
    
    
    private func addNameView() {
        nameView.text = name?.lowercased()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
