//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Andrey on 01.06.2023.
//

import UIKit
import ChameleonFramework

class CategoryViewController: SwipeTableViewController<CategoryView> {

    let coreDataManager = CoreDataManager.shared
    
    var categoryArray: [Category] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarTitle(textLabel: "Todoey")
        setupNavigationBar()

        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

        customView.tableView.dataSource = self
        customView.tableView.delegate = self

        categoryArray = coreDataManager.loadCategories()
    }

    func setupNavigationBar() {
        let addButtonAction = UIAction(title: "buttonAction") { (action) in
            var textField = UITextField()
            let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Create", style: .default) { (action) in
                
                let newCategory = self.coreDataManager.createCategory(with: textField.text!,
                                                                      color: UIColor.randomFlat().hexValue())
                self.categoryArray.append(newCategory)
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

    

    //MARK: Delete data from Swipe
    override func updateModel(at indexPath: IndexPath) {
        coreDataManager.deleteCategory(categoryArray[indexPath.row])
        categoryArray.remove(at: indexPath.row)
    }
    
    //MARK: - Override tableView DataSource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name
        cell.backgroundColor = UIColor(hexString: categoryArray[indexPath.row].color!)
        cell.textLabel?.textColor = ContrastColorOf(UIColor(hexString: categoryArray[indexPath.row].color!)!, returnFlat: true)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension CategoryViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        customView.tableView.deselectRow(at: indexPath, animated: true)

        let destinationVC = TodoListViewController()
        destinationVC.selectedCategory = categoryArray[indexPath.row]
        navigationController?.pushViewController(destinationVC, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
