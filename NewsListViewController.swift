//
//  ViewController.swift
//  NewsList
//
//  Created by air888 on 30.06.16.
//  Copyright © 2016 AntonSvita. All rights reserved.
//

import UIKit

class NewsListViewController: UITableViewController {
    
    var listOfTeNews: [News]?
    
    
    func fetchNews() {
        let url = NSURL(string: "http://madiosgames.com/api/v1/application/ios_test_task/articles")
        NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            if error != nil {
                print(error)
                return
            }
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                self.listOfTeNews = [News]()
                for dictionary in json as! [[String: AnyObject]] {
                    let news = News()
                    news.title = dictionary["title"] as! String
                    self.listOfTeNews?.append(news)
                }
                self.tableView.reloadData()
            } catch let jsonError {
                print(jsonError)
            }
            }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        fetchNews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfTeNews?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "SearchResultCell"
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .Default,
            reuseIdentifier: cellIdentifier)
        }
        cell.textLabel?.text = listOfTeNews?[indexPath.row].title
        return cell
    }
}

