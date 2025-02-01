//
//  LoadingViewController.swift
//  News App
//
//  Created by Denis Borovoi on 04.01.2025.
//

import UIKit

class LoadingViewController: UIViewController {
    
    let rectangleView = UIView()
    let loading = UIActivityIndicatorView(style: .large)
    let label = UILabel()
                                          
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0.6, alpha: 0.7)
        
        rectangleView.backgroundColor = .lightGray
        rectangleView.layer.cornerRadius = 13
        rectangleView.backgroundColor = UIColor(white: 0.3, alpha: 0.4)
        view.addSubview(rectangleView)
        rectangleView.translatesAutoresizingMaskIntoConstraints = false
        rectangleView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        rectangleView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        rectangleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rectangleView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.startAnimating()
        rectangleView.addSubview(loading)
        loading.color = .systemBlue
        loading.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loading.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        label.text = "Loading news..."
        label.textColor = .red
        label.font = UIFont(name: "Arial", size: 16)
        rectangleView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.centerXAnchor.constraint(equalTo: rectangleView.centerXAnchor, constant: 0).isActive = true
        label.topAnchor.constraint(equalTo: loading.bottomAnchor, constant: 10).isActive = true
    }
}
