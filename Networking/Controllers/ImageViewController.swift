//
//  ViewController.swift
//  Networking
//
//  Created by Roman Korobskoy on 19.11.2021.
//

import UIKit

class ImageViewController: UIViewController {
    
    private let url = "https://images.pexels.com/photos/1624496/pexels-photo-1624496.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260"

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicatior: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatior.isHidden = true
        activityIndicatior.hidesWhenStopped = true
        fetchImage()
    }
    
    func fetchImage() {
        
        activityIndicatior.isHidden = false
        activityIndicatior.startAnimating()
        
        NetworkManager.downloadImage(url: url) { image in
            self.activityIndicatior.stopAnimating()
            self.imageView.image = image
        }
    }
}

