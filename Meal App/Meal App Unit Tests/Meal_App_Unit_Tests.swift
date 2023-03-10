//
//  Meal_App_Unit_Tests.swift
//  Meal App Unit Tests
//
//  Created by Donald Dang on 3/7/23.
//

import XCTest
@testable import Meal_App

final class Meal_App_Unit_Tests: XCTestCase {
    
    var sut: NetworkingManager!
    var tableView: UITableView!
    
    override func setUp() {
        super.setUp()
        sut = NetworkingManager()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testParseData1() {
        // test fetching data
        let expectation = self.expectation(description: "Data fetched successfully")
        let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        
        // test api call
        sut.parseData(from: urlString, resultType: Meals.self) { (meals) in
            // then
            XCTAssertNotNil(meals, "Meals should not be nil") // failure case
            XCTAssertEqual(meals?.count, 64, "Meals array should have 64 items") //there are currently 64 items at time of test
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testParseData2(){
        let expectation2 = self.expectation(description: "Data fetched successfully")
        let urlString2 = "https://themealdb.com/api/json/v1/1/lookup.php?i=52893"
        
        sut.parseData(from: urlString2, resultType: Meals.self) { (meals2) in
            XCTAssertNotNil(meals2, "Meals Array should not be nil")
            XCTAssertEqual(meals2?.count, 1, "Meals Array Should be more than 1")
            expectation2.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
