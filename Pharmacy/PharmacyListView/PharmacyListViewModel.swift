//
//  PharmacyListViewModel.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 20/07/2024.
//

import Foundation
import SwiftUI
import Combine
import Alamofire
import PromiseKit

class PharmacyListViewModel: ObservableObject {
    @Published var pharmacies: [Pharmacy] = []
    @Published var isLoading = false
    @Published var errorMessage = ""

    func fetchPharmacies(authToken: String) {
        self.isLoading = true
        
        APIManager.shared.getPharmacies(authToken: authToken){[weak self] pharmacyList, error in
            if let error = error{
                self?.errorMessage = error.localizedDescription
                self?.isLoading = false
            }else{
                print("pharmacyList")
                print(pharmacyList ?? [])
                self?.pharmacies = pharmacyList ?? []
                self?.isLoading = false
            }
            
        }
    }
}

