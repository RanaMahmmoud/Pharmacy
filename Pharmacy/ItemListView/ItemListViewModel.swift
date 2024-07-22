//
//  ItemListViewModel.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 21/07/2024.
//

import Foundation
import Combine

class ItemListViewModel: ObservableObject {
    @Published var items: [Item] = []
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var selectedRequestId = 0
    @Published var selectedPharamcyId = 0
    @Published var selectedItem:Item?
    private let apiManager = APIManager.shared
    private var cancellables = Set<AnyCancellable>()
    
    init(selectedRequestId: Int = 0, selectedPharamcyId: Int = 0) {
        self.selectedRequestId = selectedRequestId
        self.selectedPharamcyId = selectedPharamcyId
    }

    func fetchItemsRequests(authToken: String, pharmacyId: Int , requestId: Int) {
        isLoading = true
        errorMessage = ""

        self.returnItemsRequests(authToken: authToken, pharmacyId: pharmacyId ,returnRequestId: requestId){ result, error in
            if let error = error{
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }else{
                if let items = result{
                    self.items = items ?? []
                }
                self.isLoading = false
            }
            self.isLoading = false
        }
    }
    func deleteItem(authToken: String, pharmacyId: Int , requestId: Int,itemId: Int) {

        apiManager.deleteItem(authToken: authToken, pharmacyId: pharmacyId, returnRequestId: requestId, itemId: itemId)
            { newItem, error in
                if let error = error{
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
            
                    print(error)
                }
                else{
                  
                    self.isLoading = false
                    
                    print("Items Deleted")
                }
                self.isLoading = false
            }
        fetchItemsRequests(authToken: authToken, pharmacyId: pharmacyId , requestId: requestId)
    }
    private func returnItemsRequests(authToken: String, pharmacyId: Int,returnRequestId: Int, onCompletion: @escaping ([Item]?, Error?) -> Void) {
        apiManager.getItems(authToken: authToken, pharmacyId: pharmacyId,returnRequestId: returnRequestId, completion: onCompletion)
    }
}


