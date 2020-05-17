//
//  CategoryLoader.swift
//  BlackStarWearShop
//
//  Created by Rustam Gradov on 09.04.2020.
//  Copyright © 2020 Rustam Gradov. All rights reserved.
//

import Foundation
import Alamofire


class CategoryLoader {
    
    func loadCategories(loadedCategories: @escaping ([Categories]) -> Void) {
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
                    loadedItemsList(itemsList)
                }
            }
        }
    }
}
