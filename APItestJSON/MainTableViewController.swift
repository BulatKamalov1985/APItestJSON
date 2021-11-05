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
        navigationItem.rightBarButtonItem = editButtonItem
        
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
        
        var content = cell.defaultContentConfiguration()
        
        content.text = breakinBad.name
        content.secondaryText = breakinBad.nickname
        content.image = nil
        cell.imageView?.image = nil
        cell.contentConfiguration = content
        
        uploadImageFromUrl(breakinBad.img, indexPath: indexPath)
        
        return cell
    }
    //    MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .none
    }
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        false
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let currentCharacter = breakingBads.remove(at: sourceIndexPath.row)
        breakingBads.insert(currentCharacter, at: destinationIndexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let characterDetailVC = segue.destination as? CharacterDetailViewController else {return}
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let characterDetail = breakingBads[indexPath.row]
        characterDetailVC.breakinB = characterDetail
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
        }.resume()
    }
}
