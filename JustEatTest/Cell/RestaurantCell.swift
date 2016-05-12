//
//  RestaurantCell.swift
//  JustEatTest
//
//  Created by Fran Abucillo on 30/4/16.
//  Copyright © 2016 Fran Ruano. All rights reserved.
//

import UIKit
import SDWebImage

class RestaurantCell: UITableViewCell {

    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    
    private let block: SDWebImageCompletionBlock! = {
        (image: UIImage!, error: NSError!, cacheType: SDImageCacheType!, imageURL: NSURL!) -> Void in
        
    }
    
    func fillCellWithData(restaurant: Restaurant) {
        lblName.text = restaurant.name
        lblDescription.text = restaurant.foodType
        lblRating.text = "\(restaurant.rating!)"
        
        if let urlStr = restaurant.urlLogoString {
            imgLogo.sd_setImageWithURL(NSURL(string: urlStr), completed: block)
        }
    }
    
}
