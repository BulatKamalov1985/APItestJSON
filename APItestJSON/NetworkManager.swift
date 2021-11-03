//
//  NetworkManager.swift
//  APItestJSON
//
//  Created by Bulat Kamalov on 02.11.2021.
//

import Foundation

class NetworkManager {
    

    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCharacter(from url: String?, with completion: @escaping(BreakinBad?) -> Void) {
        guard let url = URL(string: url ?? "0" ) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error{
                print(error)
                  print("Хуета")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let breakinBadElements = try JSONDecoder().decode(BreakinBad.self, from: data)
                DispatchQueue.main.async {
                    completion(breakinBadElements)
                    print("Распарсил епта")
                    print(breakinBadElements.first?.name ?? "00" )}
                
            } catch let error {
              print(error.localizedDescription)
                print("совсем хуета")
            }
        }.resume()
    }
}

class ImageManager {
    static var shared = ImageManager()
    
    private init() {}
    
    func fetchImage(from url: String?) -> Data? {
        guard let stringURL = url else { return nil }
        guard let imageURL = URL(string: stringURL) else { return nil }
        return try? Data(contentsOf: imageURL)
    }
}
