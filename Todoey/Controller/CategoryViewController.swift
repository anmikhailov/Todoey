//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Andrey on 01.06.2023.
//

import UIKit

class CategoryViewController: CustomViewController<CategoryView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarTitle(textLabel: "Todoey")
        setupNavigationBar()
        
        customView.delegate = self
        
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
    }
    
    func setupNavigationBar() {
        let addButtonAction = UIAction(title: "buttonAction") { (action) in
//            var textField = UITextField()
//            let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
//            let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
//                
//                let newItem = Item(context: self.context)
//                newItem.title = textField.text!
//                newItem.done = false
//                
//                self.itemArray.append(newItem)
//                self.saveItems()
//                self.customView.tableView.reloadData()
//            }
//            
//            alert.addTextField { (alertTextField) in
//                alertTextField.placeholder = "Create new item"
//                textField = alertTextField
//            }
//            
//            alert.addAction(action)
//            self.present(alert, animated: true)
        }
        
        let button = UIBarButtonItem(systemItem: .add,
                                     primaryAction: addButtonAction)
        navigationItem.rightBarButtonItem = button
        navigationController?.navigationBar.tintColor = .white
    }
}

//MARK: - CategoryViewDelegate
extension CategoryViewController: CategoryViewDelegate {
    func CategoryView(_ view: CategoryView, didTapButton button: UIButton) {
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "tableViewCell")
        return cell
    }
    
    
}
