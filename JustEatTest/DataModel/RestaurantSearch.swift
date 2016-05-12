//
//  RestaurantSearch.swift
//  JustEatTest
//
//  Created by Fran Abucillo on 30/4/16.
//  Copyright © 2016 Fran Ruano. All rights reserved.
//

import Foundation

enum DataError: ErrorType {
    case Empty
}

struct RestaurantSearch {
    private var restaurants: [Restaurant]
    
    var numberOfRestaurtants: Int {
        return restaurants.count
    }
    
    init() {
        restaurants = [Restaurant]()
    }
    
    init (restaurants: [Restaurant]) {
        self.restaurants = restaurants
    }
    
    subscript(index: Int) -> Restaurant {
         return restaurants[index]
    }
    
    func createNewSearch(data:NSArray?) -> RestaurantSearch {
        var newRestaurantSearch: RestaurantSearch
        do {
            newRestaurantSearch = try RestaurantSearch(restaurants: createArrOfRestaurants(data!))
        } catch {
            newRestaurantSearch = RestaurantSearch()
        }
        
        return newRestaurantSearch
    }
    
    func getArrayOfRestaurants () -> [Restaurant] {
        return restaurants
    }
    
    private func createArrOfRestaurants(data: NSArray) throws -> [Restaurant] {
        var restaurantsArr = [Restaurant]()
        for dict in data as! [NSDictionary] {
            restaurantsArr.append(setRestaurant(dict))
        }
        
        return restaurantsArr
    }
    
    private func setRestaurant(dict: NSDictionary) -> Restaurant {
        let name = dict["Name"] as? String
        var logoUrl: String?
        if let logo = dict["Logo"] as? NSArray, url = logo[0]["StandardResolutionURL"] as? String {
            logoUrl = url
        }
        let rating = dict["RatingAverage"] as? Float
        
        var arrFoodType = [String]()
        for dict in dict["CuisineTypes"] as! [NSDictionary] {
            if let foodType = dict["Name"] as? String {
                arrFoodType.append(foodType)
            }
        }
        
        return Restaurant(name: name, foodType: arrFoodType.joinWithSeparator(", "), rating: rating, urlLogoString: logoUrl)
    }
    
    
}