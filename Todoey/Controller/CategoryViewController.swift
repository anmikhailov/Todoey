//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Andrey on 01.06.2023.
//

import UIKit
import CoreData

class CategoryViewController: CustomViewController<CategoryView> {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categoryArray: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarTitle(textLabel: "Todoey")
        setupNavigationBar()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        customView.delegate = self
        
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
        
        loadCategories()
    }
    
    func setupNavigationBar() {
        let addButtonAction = UIAction(title: "buttonAction") { (action) in
            var textField = UITextField()
            let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Add Category", style: .default) { (action) in

                let newCategory = Category(context: self.context)
                newCategory.name = textField.text!

                self.categoryArray.append(newCategory)
                self.saveCategories()
                self.customView.tableView.reloadData()
            }

            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Create new category"
                textField = alertTextField
            }

            alert.addAction(action)
            self.present(alert, animated: true)
        }
        
        let button = UIBarButtonItem(systemItem: .add,
                                     primaryAction: addButtonAction)
        navigationItem.rightBarButtonItem = button
        navigationController?.navigationBar.tintColor = .white
    }
    
    func saveCategories() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("\(error)")
        }
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
        return categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "tableViewCell")
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        customView.tableView.deselectRow(at: indexPath, animated: true)
        
        let destinationVC = TodoListViewController()
        destinationVC.selectedCategory = categoryArray[indexPath.row]
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}
