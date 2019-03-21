//
//  MovieListTableViewController.swift
//  IRDBStoryboard
//
//  Created by Tendaishe Gwini on 20/03/2019.
//  Copyright © 2019 Tendaishe Gwini. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "irdblogo"))
        fetchData()
    }

    
    //MARK: Properties
    
    var irdbData = IRDBDataModel()
    let irdbDataManager = IRDBDataManager()
    
    
    //MARK: Data fetch methods
    
    private func fetchData() {
        
        irdbDataManager.fetchData { (data, error) in
            
            if error != nil {
                print(error?.localizedDescription)
                print(error)
            }
            
            self.irdbData = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        
        
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return irdbData.franchise.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return irdbData.franchise[section].entries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = irdbData.franchise[indexPath.section].entries[indexPath.row].name
        return cell
    }
 

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return irdbData.franchise[section].franchiseName
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "openMovie" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = segue.destination as! DetailViewController
                controller.movie = irdbData.franchise[indexPath.section].entries[indexPath.row]
            }
        }
        
        
    }
    

}
