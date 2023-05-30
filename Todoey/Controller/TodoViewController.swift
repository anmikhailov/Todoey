//
//  TodoListViewController.swift
//  TodoListey
//
//  Created by Andrey on 29.05.2023.
//

import UIKit

class TodoListViewController: CustomViewController<TodoListView> {
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appending(path: "Items.plist")
    var itemArray: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarTitle(textLabel: "Todoey")
        setupNavigationBar()
        
        customView.delegate = self
        
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
    }
    
    func setupNavigationBar() {
        let addButtonAction = UIAction(title: "buttonAction") { (action) in
            var textField = UITextField()
            let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
                
                let newItem = Item()
                newItem.title = textField.text!
                
                self.itemArray.append(newItem)
                self.saveItems()
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
        navigationController?.navigationBar.tintColor = .white
    }
    
    //MARK: - Model Manipulation Methods
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
    }
}

//MARK: - TodoListViewDelegate
extension TodoListViewController: TodoListViewDelegate {
    func TodoListView(_ view: TodoListView, didTapButton button: UIButton) {
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension TodoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "tableViewCell")
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        itemArray[indexPath.row].done.toggle()
        saveItems()
        customView.tableView.reloadData()
    }
}
