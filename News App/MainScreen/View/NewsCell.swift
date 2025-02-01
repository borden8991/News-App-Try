//
//  TableViewCell.swift
//  News App
//
//  Created by Denis Borovoi on 05.01.2025.
//

import UIKit

class NewsCell: UITableViewCell {
    
    let newsTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.sizeToFit()
        label.numberOfLines = 0
        return label
    }()
    
    let newsDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .lightGray
        label.sizeToFit()
        label.numberOfLines = 0
        return label
    }()
    
    let newsDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .lightGray
        label.sizeToFit()
        label.numberOfLines = 0
        return label
    }()
    
    let newsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    static let identifier = "NewsCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {
        [newsTitle, newsDescription, newsDate, newsImage].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            
            newsImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            newsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsImage.trailingAnchor.constraint(equalTo: newsTitle.leadingAnchor),
            newsImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            
            newsTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            newsTitle.leadingAnchor.constraint(equalTo: newsImage.trailingAnchor, constant: 25),
            newsTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),

            newsDescription.topAnchor.constraint(equalTo: newsTitle.bottomAnchor, constant: 5),
            newsDescription.leadingAnchor.constraint(equalTo: newsImage.trailingAnchor, constant: 25),
            newsDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            newsDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            newsDate.topAnchor.constraint(equalTo: newsDescription.bottomAnchor, constant: 5),
            newsDate.leadingAnchor.constraint(equalTo: newsImage.trailingAnchor, constant: 25),
            newsDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            newsDate.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    
//    func configure(task: News) {
//        newsTitle.text = task.itemName
//        itemDescription.text = task.description
//    }
}
