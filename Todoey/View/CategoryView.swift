//
//  CategoryView.swift
//  Todoey
//
//  Created by Andrey on 01.06.2023.
//

import UIKit

protocol CategoryViewDelegate: AnyObject {
    func CategoryView(_ view: CategoryView, didTapButton button: UIButton)
}

class CategoryView: CustomView {
    weak var delegate: CategoryViewDelegate?
    
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
private extension CategoryView {
    @objc func didTapButton(_ button: UIButton) {
        delegate?.CategoryView(self, didTapButton: button)
    }
}
