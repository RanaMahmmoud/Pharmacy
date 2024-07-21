//
//  WholesalersViewModel.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 20/07/2024.
//

import Foundation
import Combine
import PromiseKit

class WholesalerViewModel: ObservableObject {
    @Published var wholesalers: [Wholesaler] = []
    @Published var isLoading = false
    @Published var errorMessage = ""
    
    
    func fetchWholesalers(authToken: String, pharmacyId: Int) {
        isLoading = true
        errorMessage = ""
        
        APIManager.shared.getWholesalers(authToken: authToken, pharmacyId: pharmacyId){[weak self] wholesalers, error in
            if let error = error{
                self?.errorMessage = error.localizedDescription
                self?.isLoading = false
            }else{
                self?.wholesalers = wholesalers ?? []
                self?.isLoading = false
            }
        }
            
    }
}
