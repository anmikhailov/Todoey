//
//  TodoListViewController.swift
//  TodoListey
//
//  Created by Andrey on 29.05.2023.
//

import UIKit
import ChameleonFramework

class TodoListViewController: SwipeTableViewController<TodoListView> {
    
    let coreDataManager = CoreDataManager.shared
    var itemArray: [Item] = []
    var selectedCategory: Category? {
        didSet {
           itemArray = coreDataManager.loadItems(selectedCategory: selectedCategory)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.delegate = self
        
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
        customView.searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBarTitle(textLabel: selectedCategory?.name ?? "")
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        let addButtonAction = UIAction(title: "buttonAction") { (action) in
            var textField = UITextField()
            let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
                
                let newItem = self.coreDataManager.createItem(for: self.selectedCategory!, with: textField.text!)
                
                self.itemArray.append(newItem)
                self.customView.tableView.reloadData()
            }
            
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Create new item"
                textField = alertTextField
            }
            
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        
        let button = UIBarButtonItem(systemItem: .add,
                                     primaryAction: addButtonAction)
        navigationItem.rightBarButtonItem = button
        
        if let color = UIColor(hexString: selectedCategory?.color ?? "#FFFFFF") {
            customView.bgNavBarImageView.backgroundColor = color
            navigationController?.navigationBar.tintColor = ContrastColorOf(color, returnFlat: true)
            customView.searchBar.barTintColor = color
            
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: ContrastColorOf(color, returnFlat: true)]
        }
    }
    
    //MARK: Delete data from Swipe
    override func updateModel(at indexPath: IndexPath) {
        coreDataManager.deleteItem(itemArray[indexPath.row])
        itemArray.remove(at: indexPath.row)
    }
    
    //MARK: - Override tableView DataSource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        let categoryColor = UIColor(hexString: selectedCategory?.color ?? "#FFFFFF")
        if let color = categoryColor?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(itemArray.count)) {
            cell.backgroundColor = color
            cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
        }
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        return cell
    }
}

//MARK: - TodoListViewDelegate
extension TodoListViewController: TodoListViewDelegate {
    func TodoListView(_ view: TodoListView, didTapButton button: UIButton) {
    }
}

//MARK: - UITableViewDelegate
extension TodoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        itemArray[indexPath.row].done.toggle()
        
        coreDataManager.saveContext()
        customView.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

//MARK: - UISearchBarDelegate
extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        itemArray = coreDataManager.searchItems(text: searchBar.text!, selectedCategory: selectedCategory)
        customView.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            itemArray = coreDataManager.loadItems(selectedCategory: selectedCategory)
            customView.tableView.reloadData()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
