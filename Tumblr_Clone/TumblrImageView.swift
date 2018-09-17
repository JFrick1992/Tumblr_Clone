//
//  TumblrImageView.swift
//  Tumblr_Clone
//
//  Created by Jacob Frick on 9/15/18.
//  Copyright © 2018 Jacob Frick. All rights reserved.
//

import UIKit
import AlamofireImage
class TumblrImageView: UIViewController, UITableViewDataSource {
    var posts : [[String: Any]] = []
    var images = [String]()
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(TumblrImageView.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)

        tableView.dataSource = self
        tableView.rowHeight = 250

        self.fetchPosts()

        // Do any additional setup after loading the view.
    }
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchPosts()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchPosts() {
        let urlString = "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let resonseDictionary = dataDictionary["response"] as! [String: Any]
                self.posts = resonseDictionary["posts"] as! [[String: Any]]
                for post in self.posts {
                    let photos = post["photos"] as! [[String: Any]]
                    for photo in photos {
                        let originalDic = photo["original_size"] as! [String: Any]
                        let url = originalDic["url"] as! String
                        self.images.append(url)
                    }
                }
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! imageCell
        let urlString = self.images[indexPath.row]
        let url = URL(string: urlString)!
        
        cell.tumblrImageView.af_setImage(withURL: url)
        return cell
    }

}
