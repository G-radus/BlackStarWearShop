//
//  CategoryLoader.swift
//  BlackStarWearShop
//
//  Created by Rustam Gradov on 09.04.2020.
//  Copyright © 2020 Rustam Gradov. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD

class CategoryLoader {
    
    func loadCategories(loadedCategories: @escaping ([Categories]) -> Void) {
        SVProgressHUD.setForegroundColor(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
        SVProgressHUD.show()
        Alamofire.request("http://blackstarshop.ru/index.php?route=api/v1/categories").responseJSON {
            response in
            if let json = response.value,
                let jsonDict = json as? NSDictionary {
                var listOfCategories: [Categories] = []
                for (_, data) in jsonDict {
                    if let categories = Categories(data: data as! NSDictionary) {
                        listOfCategories.append(categories)
                    }
                }
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    loadedCategories(listOfCategories)
                }
            }
        }
    }
    
    func loadItemsList(id: String, loadedItemsList: @escaping ([ItemsList]) -> Void) {
        Alamofire.request("http://blackstarshop.ru/index.php?route=api/v1/products&cat_id=\(id)").responseJSON {
            response in
            if let json = response.value,
                let jsonDict = json as? NSDictionary {
                var itemsList: [ItemsList] = []
                for (_, data) in jsonDict {
                    if let items = ItemsList(data: data as! NSDictionary) {
                        itemsList.append(items)
                    }
                }
                
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    loadedItemsList(itemsList)
                }
            }
        }
    }
}
