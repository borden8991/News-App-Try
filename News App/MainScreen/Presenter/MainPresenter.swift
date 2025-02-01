//
//  MainPresenter.swift
//  News App
//
//  Created by Denis Borovoi on 04.01.2025.
//

import Foundation

protocol MainViewInputProtocol: AnyObject {
    
    /// Обновить экран с новостями.
    /// - Parameter news: Массив новостей.
    func updateScreen(with news: [News])
    
    func failure(error: Error)
}

class MainPresenter {
    private var isFirstAppear = true
    private var news: [News] = []
    weak private var view: MainViewInputProtocol?
    init(view: MainViewInputProtocol) {
        self.view = view
    }
    
    var allNews: [News] = []
    var allDataImage: [Data] = []
    
    let defaultUrl = URL(string: "https://1.bp.blogspot.com/--b7JV7PgDPo/Xj6jliViqZI/AAAAAAAAC60/NO3XtMYWHR00NPBc-a_wxlkszqLEB07QACLcBGAsYHQ/s1600/record.jpg)")
    
    let queue1 = DispatchQueue(label: "com.queue1", qos: .default, attributes: .concurrent)
    let group1 = DispatchGroup()
    
    let queue2 = DispatchQueue(label: "com.queue2", qos: .default, attributes: .concurrent)
    
    let queue3 = DispatchQueue(label: "com.queue3", qos: .default, attributes: .concurrent)
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//    }
}

extension MainPresenter: MainViewOutputProtocol {
    func viewDidLoad() {
        self.view?.updateScreen(with: self.news)
       // self.getRequest()
    }
    func viewWillAppear() {
        //self.moveIndicator()
    }
}



//MARK: - Request

/*extension MainPresenter {
    func getRequest() {
        for page in 1...5 {
            guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=4d00a491c6304c209858f2c60cf9dc08&page=\(page)")
            else { return }
            
            group1.enter()
            queue1.async(group: group1) {
                URLSession.shared.dataTask(with: url) { [weak self] data, responder, error in
                    guard let self = self else { return }
                    
                    if let data = data {
                        
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            guard let jsonData =  json as? [String: Any] else { return }
                            if let arrayNews = jsonData["articles"] as? NSArray {
                                for news in arrayNews {
                                    guard let currentNews = news as? [String:Any] else { return }
                                    
                                    var currentTitle: String = "No title"
                                    if let title = currentNews["title"] as? String {
                                        currentTitle = title
                                    }
                                    
                                    var currentDescrition: String = "No description"
                                    if let description = currentNews["description"] as? String {
                                        currentDescrition = description
                                    }
                                    
                                    var currentAuthor: String = "No author"
                                    if let author = currentNews["author"] as? String {
                                        currentAuthor = author
                                    }
                                    
                                    let datePublishedAt = currentNews["publishedAt"] as? String ?? ""
                                    let convertedDate = self.dateConverter(datePublishedAt)
                                    
                                    var currentURL: URL = self.defaultUrl ?? defaultUrl!
                                    if let urlString = currentNews["url"] as? String {
                                        currentURL = URL(string: urlString)!
                                    }
                                    
                                    var currentImageURL: URL = self.defaultUrl ?? defaultUrl!
                                    if let imageString = currentNews["urlToImage"] as? String {
                                        if imageString.isEmpty {
                                            currentImageURL = self.defaultUrl ?? defaultUrl!
                                        } else {
                                            currentImageURL = URL(string: imageString) ?? self.defaultUrl!
                                        }
                                    }
                                    let newsNodel = News(title: currentTitle, imageURL: currentImageURL, date: convertedDate, description: currentDescrition, author: currentAuthor, url: currentURL)
                                    self.allNews.append(newsNodel)
                                }
                            }
                            self.group1.leave()
                        } catch {
                            print("Session completely with error: \(error)")
                            self.group1.leave()
                            return
                        }
                    }
                }.resume()
            }
            group1.wait()
        }
        group1.notify(queue: .main) {
            self.downloadAllImagesByURL()
        }
    }
    
    func showAllImages() {
        DispatchQueue.main.async {
            //self.stopIndicator()
            //self.tableView.reloadData()
        }
    }
    
    func downloadAllImagesByURL() {
        queue2.asyncAndWait(flags: .barrier) {
            for news in self.allNews {
                self.queue3.async() {
                    print("news.imageUrl: \(news.imageURL) threat: \(Thread.current)")
                    do {
                        if let data = try? Data(contentsOf: news.imageURL) {
                            self.allDataImage.append(data)
                        } else {
                            let url = self.defaultUrl
                            let data = try? Data(contentsOf: url!)
                            self.allDataImage.append(data!)
                        }
                    }
                }
            }
        }
        queue2.async() {
            self.showAllImages()
        }
        self.view?.updateScreen(with: self.news)
    }
}*/

//MARK: - DataConverter

extension MainPresenter {
    func dateConverter(_ dataAsString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = formatter.date(from: dataAsString) {
            formatter.dateStyle = .short
            formatter.timeStyle = .short
            let stringDateConverted = formatter.string(from: date)
            return stringDateConverted
        }
        return "No date"
    }
}
