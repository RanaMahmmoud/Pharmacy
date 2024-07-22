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
    @Published var selectedRequestId = 0
    @Published var selectedPharamcyId = 0
    private let apiManager = APIManager.shared
    private var cancellables = Set<AnyCancellable>()
    

    func fetchReturnRequests(authToken: String, pharmacyId: Int) {
        isLoading = true
        errorMessage = ""

        self.returnRequests(authToken: authToken, pharmacyId: pharmacyId){ returnRequests, error in
            if let error = error{
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }else{
                if let requests = returnRequests{
                    self.returnRequests = requests.content ?? []
                }
                self.isLoading = false
            }
        }
    }
    
    private func returnRequests(authToken: String, pharmacyId: Int, onCompletion: @escaping (ListReturn?, Error?) -> Void) {
        apiManager.getListReturnRequests(authToken: authToken, pharmacyId: pharmacyId, completion: onCompletion)
    }
}

