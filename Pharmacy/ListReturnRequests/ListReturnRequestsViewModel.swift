//
//  ListReturnRequestsViewModel.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 21/07/2024.
//

import Foundation
import Combine

class ListReturnRequestsViewModel: ObservableObject {
    @Published var returnRequests: [ListReturnData] = []
    @Published var isLoading = false
    @Published var errorMessage = ""

    private var cancellables = Set<AnyCancellable>()

    func fetchReturnRequests(authToken: String, pharmacyId: Int) {
        isLoading = true
        errorMessage = ""

        APIManager.shared.getListReturnRequests(authToken: authToken, pharmacyId: pharmacyId){[weak self] returnRequests, error in
            if let error = error{
                self?.errorMessage = error.localizedDescription
                self?.isLoading = false
            }else{
                if let requests = returnRequests{
                    self?.returnRequests = requests.content ?? []
                }
                self?.isLoading = false
            }
        }
    }
}

