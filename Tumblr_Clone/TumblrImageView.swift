//
//  TumblrImageView.swift
//  Tumblr_Clone
//
//  Created by Jacob Frick on 9/15/18.
//  Copyright © 2018 Jacob Frick. All rights reserved.
//

import UIKit
import AlamofireImage
class TumblrImageView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    struct Post {
        let id : Int?
        let imageLink : String?
        let caption : String?
        let timestamp : Date?
    }
    
    var posts = [Post]()
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(TumblrImageView.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)

        tableView.dataSource = self
        tableView.delegate = self
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let photoViewController = segue.destination as! PhotoDetailsViewController
        let vc = sender as! imageCell
        let indexPath = tableView.indexPath(for: vc)!
        let link = posts[indexPath.section].imageLink!
        photoViewController.link = link
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
                let postsDic = resonseDictionary["posts"] as! [[String: Any]]
                for tempPost in postsDic {
                    let photos = tempPost["photos"] as! [[String: Any]]
                    let photo = photos[0]
                    let orgSizeDic = photo["original_size"] as! [String: Any]
                    let url = orgSizeDic["url"] as! String
                    let id = tempPost["id"] as? Int
                    let caption = tempPost["caption"] as! String
                    let timestamp = tempPost["timestamp"] as? Double
                    let date = Date(timeIntervalSince1970: timestamp!)
                    self.posts.append(Post(id: id, imageLink: url, caption: caption, timestamp: date))
                }
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        let profileView = UIImageView(frame: CGRect(x: 10, y: 5, width: 30, height: 30))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15;
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).cgColor
        profileView.layer.borderWidth = 1;
        
        // Set the avatar
        profileView.af_setImage(withURL: URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/avatar")!)
        headerView.addSubview(profileView)
        
        let label = UILabel(frame: CGRect(x:55, y: 5, width: 300, height: 30))
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        label.text = dateFormatter.string(from: posts[section].timestamp!)
        headerView.addSubview(label)
        // Add a UILabel for the date here
        // Use the section number to get the right URL
        // let label = ...
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! imageCell
        let urlString = self.posts[indexPath.section].imageLink!
        let url = URL(string: urlString)!
        
        cell.tumblrImageView.af_setImage(withURL: url)
        return cell
    }

}
