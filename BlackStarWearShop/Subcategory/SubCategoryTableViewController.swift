//
//  SubCategoryTableViewController.swift
//  BlackStarWearShop
//
//  Created by Rustam Gradov on 30.03.2020.
//  Copyright © 2020 Rustam Gradov. All rights reserved.
//

import UIKit


class SubCategoryTableViewController: UITableViewController {
    
    @IBOutlet var subCategoryTableView: UITableView!
    @IBOutlet weak var navigationItemTitle: UINavigationItem!
    
    var selectedID = String()
    var subcategories = Categories()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
// MARK: - Table view data source

extension SubCategoryTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subcategories.subcategories.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubCategoryCell", for: indexPath) as! SubCategoryTableViewCell
                
        self.navigationItemTitle.title = self.subcategories.name
        
        cell.subCategoryLabel.text = subcategories.subcategories[indexPath.row].name
        
        if !self.subcategories.subcategories[indexPath.row].iconImage.isEmpty {
            let url = URL(string: "http://blackstarshop.ru/\(self.subcategories.subcategories[indexPath.row].iconImage)")
            cell.subCategoryImageView.kf.setImage(with: url)
        } else {
            cell.subCategoryImageView.image = UIImage(named: "noImage")
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
              subCategoryTableView.deselectRow(at: indexPath, animated: true)
              selectedID = self.subcategories.subcategories[indexPath.row].id
              performSegue(withIdentifier: "ShowItemsListVC", sender: indexPath)
          }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let itemsListVC = segue.destination as? ItemsListViewController, segue.identifier == "ShowItemsListVC" {
            itemsListVC.id = self.selectedID
        }
    }
}

