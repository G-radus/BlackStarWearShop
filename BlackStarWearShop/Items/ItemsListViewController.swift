//
//  ItemsListViewController.swift
//  BlackStarWearShop
//
//  Created by Rustam Gradov on 19.04.2020.
//  Copyright © 2020 Rustam Gradov. All rights reserved.
//

import UIKit
import Kingfisher

protocol ItemsListViewControllerDelegate: class {
    func passProductsCount(productCount: Int)
}

class ItemsListViewController: UIViewController {
    
    
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    
    var id = String()
    var index = Int()
    var itemsList: [ItemsList] = []
    var productsCount = RealmDataBase.shared.getSavedProducts().count
    weak var delegate: ItemsListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CategoryLoader().loadItemsList(id: id) { itemsList in
            self.itemsList = itemsList
            self.itemsCollectionView.reloadData()
        }
        
//         basket.setProductCount(productCount: productsCount)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
           delegate?.passProductsCount(productCount: productsCount)
       }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
}

extension ItemsListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, ProductCardViewControllerDelegate, BasketViewControllerDelegate {
    
    func getProductsCount(productCount: Int) {
           self.productsCount = productCount
//           basket.setProductCount(productCount: productCount)
       }
       
       func passProductsCount(productCount: Int) {
           self.productsCount = productCount
//           basket.setProductCount(productCount: productsCount)
       }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let w = UIScreen.main.bounds.size.width / 2
         let h = UIScreen.main.bounds.size.height / 3
               return CGSize(width: w, height: h)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemsCell", for: indexPath) as! ItemsCollectionViewCell

        cell.titleLabel.text = itemsList[indexPath.row].name
        cell.descriptionLabel.text = itemsList[indexPath.row].description
        cell.priceLabel.text = "\(Int(round(Double(itemsList[indexPath.row].price) ?? 0))) ₽"
        
        let url = URL(string: "http://blackstarshop.ru/\(itemsList[indexPath.row].mainImage)")
        cell.itemImage.kf.setImage(with: url)
        
        return cell
    }
    
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let productCard = segue.destination as? ProductCardViewController, segue.identifier == "ShowProductCard" {
                productCard.product =  self.itemsList[index]
                productCard.delegate = self
            }
        }
    
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            self.index = indexPath.row
            performSegue(withIdentifier: "ShowProductCard", sender: indexPath)
        }
}
