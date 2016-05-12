//
//  SearchDataSource.swift
//  JustEatTest
//
//  Created by Fran Abucillo on 30/4/16.
//  Copyright © 2016 Fran Ruano. All rights reserved.
//

import UIKit

class SearchDataSource: NSObject, UITableViewDataSource {
    
    private var restaurantArr = RestaurantSearch()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantArr.numberOfRestaurtants
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("RestaurantCell", forIndexPath: indexPath) as? RestaurantCell else {
            fatalError("Cell could not be created. Fatal Error")
        }
        cell.fillCellWithData(restaurantArr[indexPath.row])
        
        return cell
    }

    func reloadTable(tableView: UITableView, data: NSDictionary) {
        restaurantArr = restaurantArr.createNewSearch(data["Restaurants"] as? NSArray)
        tableView.reloadData()
    }
}
