//
//  CharactersModel.swift
//  APItestJSON
//
//  Created by Bulat Kamalov on 02.11.2021.
//

import Foundation

// MARK: - BreakinBadElement
struct BreakinBadElement: Codable {
    let name: String?
    let occupation: [String]
    var img: String?
    let status: String?
    let nickname: String?
    let portrayed: String?
    
}

enum Status: String, Codable {
    case alive = "Alive"
    case deceased = "Deceased"
    case presumedDead = "Presumed dead"
    case unknown = "Unknown"
}

typealias BreakinBad = [BreakinBadElement]

enum URLS: String {
    case urlString = "https://www.breakingbadapi.com/api/characters"
    
}

