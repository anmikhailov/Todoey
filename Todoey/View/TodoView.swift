//
//  TodoListView.swift
//  TodoListey
//
//  Created by Andrey on 29.05.2023.
//

import UIKit

protocol TodoListViewDelegate: AnyObject {
    func TodoListView(_ view: TodoListView, didTapButton button: UIButton)
}

class TodoListView: CustomView {
    weak var delegate: TodoListViewDelegate?
    
    //MARK: - Variables
    lazy var tableView: UITableView = {
        let element = UITableView()
        element.separatorStyle = .none
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var searchBar: UISearchBar = {
        let element = UISearchBar()
        element.searchTextField.backgroundColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    //MARK: - setViews
    override func setViews() {
        super.setViews()
        
        self.addSubview(tableView)
        self.addSubview(searchBar)
    }
    
    //MARK: - layoutViews
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 70),
            searchBar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.safeAreaLayoutGuide.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

//MARK: - Target Actions
private extension TodoListView {
    @objc func didTapButton(_ button: UIButton) {
        delegate?.TodoListView(self, didTapButton: button)
    }
}
