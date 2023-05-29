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
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    //MARK: - setViews
    override func setViews() {
        super.setViews()
        
        self.addSubview(tableView)
    }
    
    //MARK: - layoutViews
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
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
