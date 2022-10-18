//
//  MealsDBFetchTests.swift
//  mealDBAppTests
//
//  Created by Jeanie Lee on 10/14/22.
//

import XCTest
@testable import mealDBApp

class MealsDBFetchTests: XCTestCase {
    var mealsClient: MealsDBFetch!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mealsClient = MealsDBFetch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCleanDataFunctionWithEmptyOrInvalidJsonData() throws {
        var jsonData = ["": nil] as [String: Any?]
        var value = mealsClient.cleanData(jsonData)
        XCTAssertNil(value)
        
        
        jsonData = ["meals": [["" : nil]]] as [String : Any?]
        value = mealsClient.cleanData(jsonData)
        XCTAssertNil(value)
    }
    
    func testCleanDataFunctionWithMismatchingData() throws {
        var jsonData = ["meals": [nil]] as [String : [Any]]
        jsonData["meals"]![0] = ["strIngredient1": nil,
                        "strMeasure1": "200g"] as [String: Any?]
        var value = mealsClient.cleanData(jsonData)
        
        // I filter out the mismatches when I present the ingredients
        XCTAssertEqual(value, MealDetail(instructions: nil, ingredientsAndMeasures: [(nil, "200g")]))
        
        jsonData["meals"]![0] = ["strIngredient1": "Egg",
                    "strMeasure1": " "] as [String: Any?]
        value = mealsClient.cleanData(jsonData)
        XCTAssertEqual(value, MealDetail(instructions: nil, ingredientsAndMeasures: [("Egg", nil)]))
    }
    
    func testCleanDataFunctionWithCorrectData() {
        var jsonData = ["meals": [nil]] as [String : [Any]]
        jsonData["meals"]![0] = ["strInstructions": "Hello Instructions\nLine1", "strIngredient1": "Egg", "strIngredient2": "  ", "strMeasure1": "1", "strMeasure2": nil]
        var value = mealsClient.cleanData(jsonData)
        XCTAssertEqual(value, MealDetail(instructions: ["Hello Instructions", "Line1"], ingredientsAndMeasures: [("Egg", "1")]))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
