//
//  ViewController.swift
//  Networking
//
//  Created by Roman Korobskoy on 19.11.2021.
//

import UIKit
import Alamofire

class ImageViewController: UIViewController {
    
    private let url = "https://images.pexels.com/photos/1624496/pexels-photo-1624496.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260"
    private let largeImage = "https://i.imgur.com/3416rvI.jpg"

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicatior: UIActivityIndicatorView!
    @IBOutlet var completedLabel: UILabel!
    @IBOutlet var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatior.startAnimating()
        activityIndicatior.hidesWhenStopped = true
        completedLabel.isHidden = true
        progressView.isHidden = true
    }
    
    func fetchImage() {
        
        NetworkManager.downloadImage(url: url) { image in
            self.imageView.image = image
        }
    }
    
    func fetchDataWithAlamofire(){
        
        AlamofireNetworkRequest.downloadImage(url: url) { image in
            self.activityIndicatior.stopAnimating()
            self.imageView.image = image
        }
    }
    
    func downloadImageWithProgress() {
        
        AlamofireNetworkRequest.onProgress = { progress in
            self.progressView.isHidden = false
            self.progressView.progress = Float(progress)
        }
            
        AlamofireNetworkRequest.completed = { completed in
                self.completedLabel.isHidden = false
                self.completedLabel.text = completed
            }
        
        AlamofireNetworkRequest.downloadImageWithProgress(url: largeImage) { image in
            self.activityIndicatior.stopAnimating()
            self.completedLabel.isHidden = true
            self.progressView.isHidden = true
            self.imageView.image = image
        }
    }
}

