//
//  Item.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 20/07/2024.
//

import Foundation

struct Item: Codable, Identifiable {
    var id: Int?
    var createdAt: String?
    var updatedAt: String?
    var ndc: String?
    var description: String?
    var manufacturer: String?
    var packageSize: String?
    var requestType: String?
    var name: String?
    var strength: String?
    var dosage: String?
    var fullQuantity: Double?
    var partialQuantity: Double?
    var expirationDate: String?
    var status: String?
    var lotNumber: String?
    var expectedReturnValue: Double?
    var actualReturnValue: Double?
    var gtin14: String?
    var serialNumber: String?
    var controlledSubstanceCode: String?
    var adminComment: String?
}
