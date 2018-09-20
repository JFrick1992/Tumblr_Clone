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
    
   
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    var post: TumblrImageView.Post!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: post.imageLink!)!
        imageView.af_setImage(withURL: url)
        captionTextView.text = post.caption
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
