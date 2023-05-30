//
//  TodoListViewController.swift
//  TodoListey
//
//  Created by Andrey on 29.05.2023.
//

import UIKit

class TodoListViewController: CustomViewController<TodoListView> {
    
    var itemArray: [Item] = []
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarTitle(textLabel: "Todoey")
        setupNavigationBar()
        
        customView.delegate = self
        
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
        
        let newItem = Item()
        newItem.title = "Find Mike"
        newItem.done = true
        itemArray.append(newItem)
        
//        if let array = defaults.array(forKey: "TodoListArray") as? [String] {
//            itemArray = array
//        }
    }
    
    func setupNavigationBar() {
        let addButtonAction = UIAction(title: "buttonAction") { (action) in
            var textField = UITextField()
            let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
                
                let newItem = Item()
                newItem.title = textField.text!
                
                self.itemArray.append(newItem)
                
                self.defaults.set(self.itemArray, forKey: "TodoListArray")
                
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
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.accessoryType = itemArray[indexPath.row].done == true ? .checkmark : .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        itemArray[indexPath.row].done.toggle()
        customView.tableView.reloadData()
    }
}
