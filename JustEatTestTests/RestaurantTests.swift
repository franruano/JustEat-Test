//
//  RestaurantTests.swift
//  JustEatTest
//
//  Created by Fran Abucillo on 30/4/16.
//  Copyright © 2016 Fran Ruano. All rights reserved.
//

import XCTest

class RestaurantTests: XCTestCase {

    var restaurant: Restaurant?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        restaurant = Restaurant(name: "Test Restaurant", foodType: "Russian", rating: 7.99, urlLogoString: "http://blablabla.com")
        
    }

    func testRestaurantName() {
        XCTAssertTrue(restaurant?.name == "Test Restaurant", "Name does not match")
    }
    
    func testRestaurantType() {
        XCTAssertTrue(restaurant?.foodType == "Russian", "Food type does not match")
    }
    
    func testRestaurantRating() {
        XCTAssertTrue(restaurant?.rating == 7.99, "Rating does not match")
    }
    
    func testRestaurantUrl() {
        XCTAssertTrue(restaurant?.urlLogoString == "http://blablabla.com", "Logo does not match")
    }

}
