//
//  ReturnRequestViewModel.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 20/07/2024.
//
import Foundation
import SwiftUI
import Combine
import Alamofire
import PromiseKit

class ReturnRequestViewModel: ObservableObject {
    @Published var returnRequest: ReturnRequest?
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var authToken = ""
    @Published var pharmacyId = 0
    @Published var requestId = 0
    
    func fetchReturnRequests(authToken: String, pharmacyId: Int , requestId: Int) {
        isLoading = true
        errorMessage = ""

        APIManager.shared.getReturnRequests(authToken: authToken, pharmacyId: pharmacyId , requestId: requestId){[weak self] returnRequests, error in
            if let error = error{
                self?.errorMessage = error.localizedDescription
                self?.isLoading = false
            }else{
                if let requests = returnRequests{
                    self?.returnRequest = requests
                }
                self?.isLoading = false
            }
        }
    }
}


