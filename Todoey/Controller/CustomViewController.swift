//
//  CustomViewController.swift
//  Todoey
//
//  Created by Andrey on 29.05.2023.
//

import UIKit

class CustomViewController<V: CustomView>: UIViewController {
    override func loadView() {
        view = V()
    }
    
    var customView: V {
        return view as! V
    }
    
    func setupNavigationBarTitle(textLabel: String) {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        
        title = textLabel
    }
}
