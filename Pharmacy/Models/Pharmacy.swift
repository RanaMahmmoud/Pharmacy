//
//  Pharmacy.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 20/07/2024.
//

import Foundation

struct Pharmacy: Codable ,Hashable , Identifiable {
    
    static func == (lhs: Pharmacy, rhs: Pharmacy) -> Bool {
        lhs.pharmacyId == rhs.pharmacyId
    }
    let id = UUID()
    
    let pharmacyId: Int?
    let doingBusinessAs: String?
    let numberOfReturns: Int?
    let enabled: Bool?
    
    
    

}


