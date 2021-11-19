//
//  ViewController.swift
//  Networking
//
//  Created by Roman Korobskoy on 19.11.2021.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var getImageButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicatior: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatior.isHidden = true
        activityIndicatior.hidesWhenStopped = true
    }
    
    @IBAction func getImagePressed(_ sender: UIButton) {
        
        label.isHidden = true
        getImageButton.isEnabled = false
        activityIndicatior.isHidden = false
        activityIndicatior.startAnimating()
        
        guard let url = URL(string: "https://images.pexels.com/photos/1624496/pexels-photo-1624496.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260") else { return }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.activityIndicatior.stopAnimating()
                    self.imageView.image = image
                }
            }
        }
        .resume()
    }
    
}

