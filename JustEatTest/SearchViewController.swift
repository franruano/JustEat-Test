//
//  SearchViewController.swift
//  JustEatTest
//
//  Created by Fran Abucillo on 30/4/16.
//  Copyright © 2016 Fran Ruano. All rights reserved.
//

import UIKit
import CoreLocation


class SearchViewController: UIViewController  {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var btnCurrentPosition: UIButton!
    
    
    let searchDataSource = SearchDataSource()
    var dataManager: DataManager?
    var locationController: LocationController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = searchDataSource
        dataManager?.delegate = self
        locationController?.delegate = self
    }
    
    //MARKS : Actions
    
    @IBAction func btnCurrentPosition_Pressed(sender: AnyObject) {
        locationController?.startLocationManager()
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        dataManager?.basicRequest(searchBar.text!)
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        btnCurrentPosition.hidden = false
        btnCurrentPosition.alpha = 1.0
        tableView.alpha = 0.5
        return true
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        tableView.alpha = 1.0
        btnCurrentPosition.alpha = 0
        btnCurrentPosition.hidden = true
        
        return true
    }
}

extension SearchViewController: DataManagerDelegate {

    func didFinishBasicNetworkRequest(data: NSDictionary?) {
        if let data = data {
            searchDataSource.reloadTable(tableView, data: data)
        }
        //Feedback with error in else 
    }
    
    func didFinishBasicNetworkRequestWithError(error: NSError?) {
     
        
    }
}

extension SearchViewController: LocationControllerDelegate {
    func locationController(userInfo: NSDictionary, locationCoordenates: CLLocation) {
        locationController?.stopLocationManager()
        searchBar.text = userInfo["PostalCode"] as? String
    }
}
