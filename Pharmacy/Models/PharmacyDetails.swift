//
//  PharmacyDetails.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 21/07/2024.
//

import Foundation

struct PharmacyResponse: Codable {
    let pharmacy: PharmacyDetails
    let pharmacyCompanyAddressInfo: AddressInfo
    let pharmacyMailingAddressInfo: AddressInfo
    let pharmacyContactInfo: ContactInfo
    let promoCode: String?
}

struct PharmacyDetails: Codable, Identifiable {
    let id: Int
    let createdAt: String?
    let updatedAt: String?
    let user: UserData
    let enabled: Bool
    let licenseState: String
    let licenseStateCode: String
    let npi: String
    let doingBusinessAs: String
    let legalBusinessName: String
    let companyType: String
    let reimbursementType: String
    let directDepositInfo: String?
    let wholesalersLinks: [WholesalerLink]
    let dea: String
}



struct AddressInfo: Codable, Identifiable {
    let id: Int
    let createdAt: String
    let updatedAt: String
    let address1: String
    let address2: String?
    let city: String
    let state: String
    let zip: String
}

struct ContactInfo: Codable, Identifiable {
    let id: Int
    let createdAt: String
    let updatedAt: String
    let firstName: String
    let lastName: String
    let email: String
    let title: String
    let phone: String
    let fax: String
    let additionalContact1: String?
    let additionalContact2: String?
}

struct WholesalerLink: Codable, Identifiable {
    let id = UUID()
    let address: String
    let city: String
    let state: String
    let zipCode: String
    let pharmacyId: Int
    let wholesalerId: Int
    let primary: Bool
}
