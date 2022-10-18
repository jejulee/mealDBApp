//
//  MealDetail.swift
//  mealDBApp
//
//  Created by Jeanie Lee on 10/14/22.
//

import Foundation

struct MealDetail {
    let instructions: [String]?
    let ingredientsAndMeasures: [(String?, String?)]?
}

extension MealDetail: Equatable {
    static func == (lhs: MealDetail, rhs: MealDetail) -> Bool {
        var instrEq = false
        var ingrEq = false
        
        if lhs.instructions == nil && rhs.instructions == nil {
            instrEq = true}
        else if let instrL = lhs.instructions, let instrR = rhs.instructions {
            instrEq = (instrL == instrR)
        }
        
        if lhs.ingredientsAndMeasures == nil && rhs.ingredientsAndMeasures == nil {
            ingrEq = true}
        else if let ingrL = lhs.ingredientsAndMeasures, let ingrR = rhs.ingredientsAndMeasures {
            ingrEq = true
            for item in ingrL {
                if !ingrR.contains(where: {$0.0 == item.0 && $0.1 == item.1}) {
                    ingrEq = false
                    break
                }
            }
        }
        
        print(instrEq, ingrEq)
        return instrEq && ingrEq
    }
    
    
}
