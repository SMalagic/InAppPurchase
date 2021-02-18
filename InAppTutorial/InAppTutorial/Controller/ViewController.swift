//
//  ViewController.swift
//  InAppTutorial
//
//  Created by futurino on 16.02.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        

    }
   
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        cell.textLabel?.text = products[indexPath.row].title
        cell.detailTextLabel?.text = products[indexPath.row].description
        cell.imageView?.image = UIImage(named: products[indexPath.row].img)
        cell.imageView?.layer.cornerRadius = 10
        cell.textLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 17)
        cell.detailTextLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 12)
        cell.textLabel?.textColor = .darkGray
        cell.detailTextLabel?.textColor = .lightGray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}



