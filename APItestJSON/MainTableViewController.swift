//
//  MainTableViewController.swift
//  APItestJSON
//
//  Created by Bulat Kamalov on 02.11.2021.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var breakingBads: BreakinBad = []
    
        override func viewDidLoad() {
        super.viewDidLoad()
            
        tableView.backgroundColor = .systemYellow
        NetworkManager.shared.fetchCharacter(from: URLS.urlString.rawValue) { breakinBadResult in
            guard let breakinBad = breakinBadResult else { return }
            self.breakingBads = breakinBad
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
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
        cell.imageView?.image = nil
        //        uploadImageFromUrl(breakinBad.img, indexPath: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "show", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destenation = segue.destination as? ViewController {
            destenation.breakinB = breakingBads[tableView.indexPathForSelectedRow?.row ?? 0]
        }
    }
    
    func uploadImageFromUrl(_ stringUrl: String?, indexPath: IndexPath) {
        guard
            let stringUrl = stringUrl,
            let url = URL(string: stringUrl)
        else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                return
            }
            
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else { return }
                
                let cell = self?.tableView.cellForRow(at: indexPath)
                cell?.imageView?.image = image
            }
        }
        .resume()
    }
}
