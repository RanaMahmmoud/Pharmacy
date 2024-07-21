//
//  LoginResponse.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 20/07/2024.
//

import Foundation

struct LoginResponse: Decodable {
    let token: String
    let userInfo: UserInfo
}

