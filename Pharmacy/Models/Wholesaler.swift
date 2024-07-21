//
//  Wholesaler.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 20/07/2024.
//

import Foundation

struct Wholesaler: Codable, Identifiable {
   
    
    let id: Int
    let name: String
    let accountNumber: String?
    let pharmaciesLinks: [PharmacyLink]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case accountNumber
        case pharmaciesLinks = "pharmaciesLinks"
    }
}

struct PharmacyLink: Codable, Identifiable ,Hashable{
    
    let id = UUID()  // Generating unique id for each link
    let address: String
    let city: String
    let state: String
    let zipCode: String
    let pharmacyId: Int
    let wholesalerId: Int
    let primary: Bool
    
    enum CodingKeys: String, CodingKey {
        case address
        case city
        case state
        case zipCode
        case pharmacyId
        case wholesalerId
        case primary
    }
}

