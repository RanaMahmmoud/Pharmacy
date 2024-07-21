//
//  ReturnRequest.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 20/07/2024.
//

import Foundation

struct ReturnRequest: Codable {
    var id: Int?
    var createdAt: String?
    var updatedAt: String?
    var pharmacy: PharmacyData?
    var dateDispatched: String?
    var dateFulfilled: String?
    var disbursements: String?
    var serviceFee: String?
    var returnRequestStatus: String
    var returnRequestStatusLabel: String
    var serviceType: String
    var preferredDate: String?
}
struct ReturnRequestData: Codable, Identifiable {
    let id: Int?
    let createdAt: Int?
    let updatedAt: String?
    let pharmacy: PharmacyData?
    let dateDispatched: String?
    let dateFulfilled: String?
    let disbursements: String?
    let serviceFee: String?
    let returnRequestStatus: String
    let returnRequestStatusLabel: String
    let serviceType: String
    let preferredDate: String?
}
struct PharmacyData: Codable {
    var id: Int?
    var createdAt: String?
    var updatedAt: String?
    var user: UserData?
    var enabled: Bool?
    var licenseState: String?
    var licenseStateCode: String?
    var npi: String?
    var doingBusinessAs: String?
    var legalBusinessName: String?
    var companyType: String?
    var reimbursementType: String?
    var directDepositInfo: String?
    var dea: String?
}


struct UserData: Codable, Identifiable {
    let id: Int
    let createdAt: String?
    let updatedAt: String?
    let username: String?
    let password: String?
    let email: String?
    let role: String?
    let phoneNumber: String?
    let activated: Bool?
}


struct ListReturnData: Codable , Identifiable {
    

    let id = UUID()

    let returnRequest : ReturnRequestData?
    
}
struct ListReturn:Codable {
    
    let content : [ListReturnData]?
    
}
