//
//  TodoListViewController.swift
//  TodoListey
//
//  Created by Andrey on 29.05.2023.
//

import UIKit

class TodoListViewController: CustomViewController<TodoListView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(textLabel: "Todoey")
        customView.delegate = self
    }
}

//MARK: - TodoListViewDelegate
extension TodoListViewController: TodoListViewDelegate {
    func TodoListView(_ view: TodoListView, didTapButton button: UIButton) {
    }
}
