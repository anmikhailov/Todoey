//
//  CustomView.swift
//  Todoey
//
//  Created by Andrey on 29.05.2023.
//

import UIKit

class CustomView: UIView {
    
    private lazy var bgNavBarImageView: UIImageView = {
        let element = UIImageView()
        element.backgroundColor = .systemCyan
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setViews()
        layoutViews()
    }

    /// Set your view and its subviews here.
    func setViews() {
        backgroundColor = .systemBackground
        
        self.addSubview(bgNavBarImageView)
    }

    /// Layout your subviews here.
    func layoutViews() {
        NSLayoutConstraint.activate([
            bgNavBarImageView.topAnchor.constraint(equalTo: self.topAnchor),
            bgNavBarImageView.heightAnchor.constraint(equalToConstant: 150),
            bgNavBarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bgNavBarImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
    }
    
}
