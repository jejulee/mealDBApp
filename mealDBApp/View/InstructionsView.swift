//
//  InstructionsView.swift
//  mealDBApp
//
//  Created by Jeanie Lee on 10/16/22.
//

import Foundation
import UIKit

class InstructionsView: UIView{
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
        self.addSubview(container)
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func load(_ instr: [String]?) {
        guard let instr = instr else { loadingText.text = "Failed to fetch instructions"; return}
        loadingText.isHidden = true
        var num = 1
        
        var prev: UILabel?
        for step in instr {
            let s = String(num) + ". " + step + "\n"
            let label = buildStep(s)
            container.addSubview(label)
            
            if let prev = prev {
                label.topAnchor.constraint(equalTo: prev.bottomAnchor).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: container.topAnchor, constant: 5).isActive = true
            }
            
            
            prev = label
            num += 1
        }
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            container.widthAnchor.constraint(equalTo: self.widthAnchor),
            container.bottomAnchor.constraint(equalTo: prev!.bottomAnchor)
        ])
        self.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
    }
    
    func buildStep(_ text: String) -> UILabel {
        let label = UILabel()
        
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.preferredMaxLayoutWidth = 350
        label.numberOfLines = 0
        return label
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
