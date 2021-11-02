//
//  MainTableViewController.swift
//  APItestJSON
//
//  Created by Bulat Kamalov on 02.11.2021.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    
    let breakingBads: BreakinBad = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "https://www.breakingbadapi.com/api/characters"
        NetworkManager.shared.fetchCharacter(from: urlString) { _ in
            let df = ""
            print(df)
        }
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return breakingBads.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let breakinBad = breakingBads[indexPath.row]
        cell.textLabel?.text = breakinBad.name
        cell.detailTextLabel?.text = breakinBad.nickname
        
        
        return cell
    }
    
    private func fetchData(from url: String?) {
        
    }
    
    
}

