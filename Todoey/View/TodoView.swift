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
    // Add private lazy variables here
    
    //MARK: - setViews
    override func setViews() {
        super.setViews()
        
        // Add subviews here
    }
    
    //MARK: - layoutViews
    override func layoutViews() {
        super.layoutViews()
        
        // Add constraints here
    }
}

//MARK: - Target Actions
private extension TodoListView {
    @objc func didTapButton(_ button: UIButton) {
        delegate?.TodoListView(self, didTapButton: button)
    }
}
