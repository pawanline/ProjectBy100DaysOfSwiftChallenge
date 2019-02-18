//
//  ViewController.swift
//  Project1
//
//  Created by Pawan Kumar on 17/02/19.
//  Copyright © 2019 PawanShivHari inc. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        title = "Storm Viewer"
            navigationController?.navigationBar.prefersLargeTitles = true
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                // this is picture to load
                pictures.append(item)
            }
        }
        
      // sorting method 1
        
        //self.pictures = pictures.sorted()
      
          // sorting method 2
//        self.pictures = pictures.sorted(by: { (item1, item2) -> Bool in
//            return item1.compare(item2) == ComparisonResult.orderedAscending
//        })
        
          // sorting method 3
        // self.pictures = pictures.sorted(by: <)
        
        // sorting method 4
     // _ = pictures.sort{ $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        
        
        // sorting method 5
        
//        _ = pictures.sort(by: { (item1, item2) -> Bool in
//            return item1.localizedCaseInsensitiveCompare(item2) == ComparisonResult.orderedAscending
//        })
        
      
        print(pictures)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Details") as? DetailViewController {
            vc.selectedImage = self.pictures[indexPath.row]
            vc.pictures = self.pictures
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}

