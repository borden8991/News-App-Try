//
//  ViewController.swift
//  News App
//
//  Created by Denis Borovoi on 04.01.2025.
//

import UIKit

class ViewController: UIViewController {
    
    var presenter: MainViewOutputProtocol?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = .systemBlue
        return tableView
    }()
    
    private var allNews: [News] = []
    var allDataImage: [Data] = []
    
    let childView = LoadingViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        configureNavigation()
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.viewWillAppear()
    }
}

extension ViewController {
    func configureNavigation() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "US News"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.systemBlue]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.systemBlue]
        navigationController?.navigationBar.barTintColor = UIColor.green
    }
    
    func setView() {
        let currentView = setupTableView()
        view.addSubview(currentView)
    }
    
    func setupTableView() -> UIView {
        let currentView = UIView()
        let tableView = UITableView
        currentView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: currentView.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: currentView.rightAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: currentView.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: currentView.bottomAnchor, constant: 0).isActive = true
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return currentView
    }
}

//MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        1
//    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        137
    }
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
}

//MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell else { return UITableViewCell() }
        if allNews.count > 0 && allDataImage.count > 0 {
            let news = allNews[indexPath.row]
             
            let dataImage = allDataImage[indexPath.row]
            cell.newsImage.image = UIImage(data: dataImage)
            cell.newsDate.text = news.date
            cell.newsDescription.text = news.description
            cell.newsTitle.text = news.title
            
            cell.selectionStyle = .none
        }
        return cell
    }
}

extension ViewController: MainViewInputProtocol {
    func updateScreen(with news: [News]) {
        self.allNews = news
        tableView.reloadData()
    }
    
    func failure(error: any Error) {
        print(error.localizedDescription)
    }
}

extension ViewController {
    func stopIndicator() {
        childView.willMove(toParent: nil)
        childView.view.removeFromSuperview()
        childView.removeFromParent()
    }
    func moveIndicator() {
       addChild(childView)
        childView.view.frame = view.frame
        view.addSubview(childView.view)
        childView.didMove(toParent: self)
    }
}


