//
//  PharmacyDetailsViewModel.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 21/07/2024.
//

import Foundation
import SwiftUI
import Combine
import Alamofire
import PromiseKit

class PharmacyDetailsViewModel: ObservableObject {
    @Published var pharmacyDetails: PharmacyResponse?
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var authToken = ""
    @Published var pharmacyId = 0
    
    func fetchPharmacyDetailsRequests(authToken: String, pharmacyId: Int) {
        isLoading = true
        errorMessage = ""

        APIManager.shared.getPharmacyDetailsRequests(authToken: authToken, pharmacyId: pharmacyId){[weak self] returnRequests, error in
            if let error = error{
                self?.errorMessage = error.localizedDescription
                self?.isLoading = false
            }else{
                if let requests = returnRequests{
                    self?.pharmacyDetails = requests
                }
                self?.isLoading = false
            }
        }
    }
}


