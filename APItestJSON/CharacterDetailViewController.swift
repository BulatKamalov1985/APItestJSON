//
//  ViewController.swift
//  APItestJSON
//
//  Created by Bulat Kamalov on 01.11.2021.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    var breakinB: BreakinBadElement?
    
    @IBOutlet weak var imageLabel: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var occopationLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var portrayedLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        stackView.layer.masksToBounds = true
        stackView.layer.cornerRadius = 5
        
        nameLabel.text = breakinB?.name
        nickNameLabel.text = breakinB?.nickname
        occopationLabel.text = breakinB?.occupation.first
        statusLabel.text = breakinB?.status
        portrayedLabel.text = breakinB?.portrayed
        uploadImageFromUrl(breakinB?.img)
    }
    
    func uploadImageFromUrl(_ stringUrl: String?) {
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
                self?.imageLabel.image = image
                self?.activityIndicator.stopAnimating()
            }
        }.resume()
    }
}
