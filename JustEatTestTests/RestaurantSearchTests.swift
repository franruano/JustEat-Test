//
//  RestaurantSearchTests.swift
//  JustEatTest
//
//  Created by Fran Abucillo on 1/5/16.
//  Copyright © 2016 Fran Ruano. All rights reserved.
//

import XCTest

class RestaurantSearchTests: XCTestCase {

    let restaurant1: String = "{\"Badges\": [],\"Score\": 8.811587,\"DriveDistance\": 1.8,\"DriveInfoCalculated\": true,\"NewnessDate\": \"2013-06-26T00:00:00Z\",\"DeliveryMenuId\": 106051,\"DeliveryOpeningTime\": \"2016-04-30T10:30:00Z\",\"DeliveryCost\": 0,\"MinimumDeliveryValue\": 10,\"DeliveryTime\": 45,\"OpeningTime\": \"/Date(1462098600000+0000)/\",\"OpeningTimeIso\": \"2016-05-01T10:30:00Z\",\"SendsOnItsWayNotifications\": false,\"RatingAverage\": 4.51,\"Latitude\": 51.435505,\"Longitude\": -0.106595,\"Id\": 30172,\"Name\": \"Godfather Pizza Wood Oven\",\"Address\": \"152 Norwood Road\",\"Postcode\": \"SE27 9AZ\",\"City\": \"London\",\"CuisineTypes\": [{\"Id\": 27,\"Name\": \"Italian\",\"SeoName\": \"italian\"},{\"Id\": 82,\"Name\": \"Pizza\",\"SeoName\": \"pizza\"}],\"Url\": \"\",\"IsOpenNow\": true,\"IsSponsored\": true,\"IsNew\": false,\"IsTemporarilyOffline\": false,\"ReasonWhyTemporarilyOffline\": \"\",\"UniqueName\": \"godfather-pizza-se27\",\"IsCloseBy\": false,\"IsHalal\": false,\"DefaultDisplayRank\": 0,\"IsOpenNowForDelivery\": true,\"IsOpenNowForCollection\": true,\"RatingStars\": 4.5,\"Logo\": [{\"StandardResolutionURL\": \"http://d30v2pzvrfyzpo.cloudfront.net/uk/images/restaurants/30172.gif\"}],\"Deals\": [],\"NumberOfRatings\": 182}"
    
    let restaurant2: String = "{\"Badges\": [],\"Score\": 8.811587,\"DriveDistance\": 1.8,\"DriveInfoCalculated\": true,\"NewnessDate\": \"2013-06-26T00:00:00Z\",\"DeliveryMenuId\": 106051,\"DeliveryOpeningTime\": \"2016-04-30T10:30:00Z\",\"DeliveryCost\": 0,\"MinimumDeliveryValue\": 10,\"DeliveryTime\": 45,\"OpeningTime\": \"/Date(1462098600000+0000)/\",\"OpeningTimeIso\": \"2016-05-01T10:30:00Z\",\"SendsOnItsWayNotifications\": false,\"RatingAverage\": 4.51,\"Latitude\": 51.435505,\"Longitude\": -0.106595,\"Id\": 30172,\"Name\": \"Far Far Away\",\"Address\": \"152 Norwood Road\",\"Postcode\": \"SE27 9AZ\",\"City\": \"London\",\"CuisineTypes\": [{\"Id\": 27,\"Name\": \"Japanese\",\"SeoName\": \"japanese\"},{\"Id\": 82,\"Name\": \"Rum\",\"SeoName\": \"rum\"}],\"Url\": \"\",\"IsOpenNow\": true,\"IsSponsored\": true,\"IsNew\": false,\"IsTemporarilyOffline\": false,\"ReasonWhyTemporarilyOffline\": \"\",\"UniqueName\": \"godfather-pizza-se27\",\"IsCloseBy\": false,\"IsHalal\": false,\"DefaultDisplayRank\": 0,\"IsOpenNowForDelivery\": true,\"IsOpenNowForCollection\": true,\"RatingStars\": 4.5,\"Logo\": [{\"StandardResolutionURL\": \"http://d30v2pzvrfyzpo.cloudfront.net/uk/images/restaurants/30172.gif\"}],\"Deals\": [],\"NumberOfRatings\": 182}"



    var arr = [NSDictionary]()
    var restaurantSearch:RestaurantSearch?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        if let rest1 = convertStringToDictionary(restaurant1) {
            arr.append(rest1)
        }
        if let rest2 = convertStringToDictionary(restaurant2) {
            arr.append(rest2)
        }
        
        restaurantSearch = RestaurantSearch()
    }
    
    func testInitRestaurant() {
        XCTAssertNotNil(restaurantSearch, "RestaurantSearch return NIL")
        XCTAssertEqual(restaurantSearch?.numberOfRestaurtants, 0, "RestaurantSearch return more than 0 elements")
    }

    func testCreateNewRestaurant() {
        restaurantSearch = restaurantSearch?.createNewSearch(arr)
        XCTAssertEqual(restaurantSearch?.numberOfRestaurtants, 2, "RestaurantSearch return not equal to 2 elements")
    }
    
    func testCreateNewRestaurantName() {
        restaurantSearch = restaurantSearch?.createNewSearch(arr)
        XCTAssertTrue(restaurantSearch?[0].name == "Godfather Pizza Wood Oven", "First restuarant wrong name")
    }
    
    func testCreateNewRestaurantRating() {
        restaurantSearch = restaurantSearch?.createNewSearch(arr)
        XCTAssertEqualWithAccuracy(Double((restaurantSearch?[0].rating)!), 4.5, accuracy: 0.05, "First restuarant wrong rating")
    }


    private func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
}
