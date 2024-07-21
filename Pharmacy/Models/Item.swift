//
//  Item.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 20/07/2024.
//

import Foundation

struct Item: Identifiable, Codable {
    var id: String
    var ndc: String
    var description: String
    var manufacturer: String
    var fullQuantity: Int
    var partialQuantity: Int
    var expirationDate: String
    var lotNumber: String
}
