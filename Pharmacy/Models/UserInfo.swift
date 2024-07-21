//
//  UserInfo.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 20/07/2024.
//

import Foundation

struct UserInfo: Decodable {
    let id: Int
    let createdAt: String
    let updatedAt: String?
    let username: String
    let email: String
    let role: String
    let phoneNumber: String?
    let activated: Bool
}
