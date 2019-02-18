//
//  DetailViewController.swift
//  Project1
//
//  Created by Pawan Kumar on 17/02/19.
//  Copyright © 2019 PawanShivHari inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return navigationController?.hidesBarsOnTap ?? false
    }
    
    var selectedImage:String?
    var pictures: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //title = selectedImage
        if let selectedImg = selectedImage , let index = self.pictures.firstIndex(of: selectedImg){
            title = "Pictures " +  "\(index + 1)" + " rof \(pictures.count)"
        }
      
        navigationItem.largeTitleDisplayMode = .never
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnTap = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

   

}
