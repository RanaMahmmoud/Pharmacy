//
//  CreateReturnRequestViewModel.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 20/07/2024.
//

import Foundation
import Combine

class CreateReturnRequestViewModel: ObservableObject {
    @Published var wholesalers: [Wholesaler] = []
    @Published var errorMessage: String?
    @Published var successMessage: String?
    @Published var isCreated: Bool = false
    @Published var isFailed: Bool = false
    let authToken: String
    let pharmacyId: Int

    private var cancellables = Set<AnyCancellable>()
    private let repository = PharmacyRepository()

    init(authToken: String, pharmacyId: Int) {
        self.authToken = authToken
        self.pharmacyId = pharmacyId
    }

    func fetchWholesalers() {
        repository.getWholesalers(authToken: authToken, pharmacyId: pharmacyId)
            .done { wholesalers in
                self.wholesalers = wholesalers
            }
            .catch { error in
                self.errorMessage = error.localizedDescription
            }
    }

    func createReturnRequest(serviceType: String, wholesalerId: Int) {
        
        APIManager.shared.createReturnRequest(authToken: authToken, pharmacyId: pharmacyId, serviceType: serviceType, wholesalerId: wholesalerId){[weak self] returnRequest, error in
            if let error = error{
                self?.errorMessage = error.localizedDescription
                self?.isFailed = true
            }else{
                self?.successMessage = "Successfully create a return request!"
                self?.isCreated = true
                print("Return Request Created: \(returnRequest)")
            }
            
        }
    }
}
