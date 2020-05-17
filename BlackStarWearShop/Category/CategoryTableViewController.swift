//
//  CategoryTableViewController.swift
//  BlackStarWearShop
//
//  Created by Rustam Gradov on 30.03.2020.
//  Copyright © 2020 Rustam Gradov. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryTableViewController: UITableViewController {
    
    
    @IBOutlet var categoryTableView: UITableView!
    
    var categories: [Categories] = []
    var rowSelected = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CategoryLoader().loadCategories { categories in
            self.categories = categories
            self.categoryTableView.reloadData()
        }
    }
}
// MARK: - Table view data source

extension CategoryTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
        cell.categoryLabel.text = categories[indexPath.row].name
        let url = URL(string: "http://blackstarshop.ru/\(categories[indexPath.row].iconImageActive)")
        cell.categoryImageView.kf.setImage(with: url)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let subCategoryController = segue.destination as? SubCategoryTableViewController, segue.identifier == "showSubCatVC" {
            subCategoryController.subcategories = self.categories[rowSelected]
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowSelected = indexPath.row
        categoryTableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showSubCatVC", sender: indexPath)
    }
}
