//
//  DataBase.swift
//  BlackStarWearShop
//
//  Created by Rustam Gradov on 12.05.2020.
//  Copyright © 2020 Rustam Gradov. All rights reserved.
//

import Foundation
import RealmSwift

class Product: Object {
    @objc dynamic var quantity = String()
    @objc dynamic var titleLabel = String()
    @objc dynamic var sizeLabel = String()
    @objc dynamic var colorLabel = String()
    @objc dynamic var priceLabel = String()
    @objc dynamic var productOfferID = String()
    @objc dynamic var image = String()
}

class RealmDataBase {
    static let shared = RealmDataBase()
    private var product = ItemsList()
    private var productsList: [ItemsList] = []
    
    private let realm = try! Realm()
    
    func setProduct(product: ItemsList) {
        self.product = product
    }
    
    func recordProduct() {
        try! realm.write {
            let currentProduct = Product()
            
            currentProduct.colorLabel = product.colorName
            currentProduct.priceLabel = product.price
            currentProduct.productOfferID = product.offers[0].productOfferID
            currentProduct.quantity = product.offers[0].quantity
            currentProduct.sizeLabel = product.offers[0].size
            currentProduct.titleLabel = product.name
            currentProduct.image = product.mainImage
            
            realm.add(currentProduct)
        }
    }
    
    func getSavedProducts() -> [ItemsList] {
        productsList = []
        
        for prod in realm.objects(Product.self) {
            productsList.append(ItemsList(quantity: prod.quantity, titleLabel: prod.titleLabel, sizeLabel: prod.sizeLabel, colorLabel: prod.colorLabel, priceLabel: prod.priceLabel, productOfferID: prod.productOfferID, image: prod.image))
        }
        
        return productsList
    }
    
    func deleteAllProducts() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func deleteProduct(id: String) {
        for prod in realm.objects(Product.self) {
            if id == prod.productOfferID {
                try! realm.write {
                    realm.delete(prod)
                }
                break
            }
        }

        productsList = []
    }
    
    func isEmpty() -> Bool {
        return realm.objects(Product.self).isEmpty
    }
}

