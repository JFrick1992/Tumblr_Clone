//
//  PhotoDetailsViewController.swift
//  Tumblr_Clone
//
//  Created by Jacob Frick on 9/17/18.
//  Copyright © 2018 Jacob Frick. All rights reserved.
//

import UIKit
import AlamofireImage
class PhotoDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var link: String!
    var post: TumblrImageView.Post!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: link)!
        imageView.af_setImage(withURL: url)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
