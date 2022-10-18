//
//  IngredientsAndMeasuresView.swift
//  mealDBApp
//
//  Created by Jeanie Lee on 10/16/22.
//

import Foundation
import UIKit

class IngredientsAndMeasuresView: UIView {
    let loadingText: UILabel = {
        let label = UILabel()
        label.text = "Loading Instructions..."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private let container = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(loadingText)
        container.translatesAutoresizingMaskIntoConstraints = false
        loadingText.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(container)
    }
    
    func load(_ ingr: [(String?, String?)]?) {
        guard let ingr = ingr else { loadingText.text = "Failed to fetch ingredients"; return}
        loadingText.isHidden = true
        
        // Format each pair of strings, ingredient and measurement
        var prev: UILabel?
        for (i,m) in ingr {
            
            // Filter out tuples that do not have an ingredients value
            guard let i = i else {continue}
            let label = buildItem(i,m)
            container.addSubview(label)
            
            if let prev = prev {
                label.topAnchor.constraint(equalTo: prev.bottomAnchor).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: container.topAnchor, constant: 5).isActive = true
            }
            
            prev = label
        }
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            container.widthAnchor.constraint(equalTo: self.widthAnchor),
            container.bottomAnchor.constraint(equalTo: prev!.bottomAnchor)
        ])
        self.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
    }
    
    // Return UILabel for each pair of items
    func buildItem(_ ing: String, _ meas: String?) -> UILabel {
        let label = UILabel()
        label.text = ing + ", " + (meas ?? "")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
