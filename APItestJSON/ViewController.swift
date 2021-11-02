//
//  ViewController.swift
//  APItestJSON
//
//  Created by Bulat Kamalov on 01.11.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://www.breakingbadapi.com/api/characters"
        guard let url = URL(string: urlString) else {return}

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error{
                print(error.localizedDescription)
                return
            }

            guard let data = data else { return }

            let jsonString = String(data: data, encoding: .utf8)
            print(jsonString ?? "0")
        }.resume()
    }
}

