//
//  ViewController.swift
//  Project1
//
//  Created by Melis Yazıcı on 27.09.22.
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
        var items = try! fm.contentsOfDirectory(atPath: path)
        items.sort()
        
        for item in items {
            if item.hasPrefix("nssl"){
                // this is a picture to load!
                pictures.append(item)
            }
        }
        
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share with friends", style: .plain, target: self, action: #selector(appShared))
        
    }
    
    @objc func appShared() {
        if let url = URL(string: "https://apps.apple.com/us/app/idxxxxxxxx?ls=1&mt=8") {
            
            let vc = UIActivityViewController(activityItems: ["Check my app at \(url)"], applicationActivities: [])
            vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            present(vc, animated: true)
        }
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = "Picture \(indexPath.row + 1) of \(pictures.count)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                                                                            // I want to treat this is a DetailViewController so please try and     convert it to one.
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.totalPictures = pictures.count
            vc.selectedPictureNumber = indexPath.row
            vc.selectedImage = pictures[vc.selectedPictureNumber]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    
    
    
}

