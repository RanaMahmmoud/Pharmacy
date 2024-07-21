//
//  ItemViewModel.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 20/07/2024.
//
import Foundation
import Combine

class ItemViewModel: ObservableObject {
    @Published var items: [Item] = []
    @Published var errorMessage: String?
    let authToken: String
    let currentReturnRequest: ReturnRequest

    private var cancellables = Set<AnyCancellable>()
    private let repository = PharmacyRepository()

    init(currentReturnRequest: ReturnRequest, authToken: String) {
        self.currentReturnRequest = currentReturnRequest
        self.authToken = authToken
    }

//    func fetchItems() {
//        repository.getItems(authToken: authToken, pharmacyId: currentReturnRequest.pharmacyId, returnRequestId: currentReturnRequest.id)
//            .done { items in
//                self.items = items
//            }
//            .catch { error in
//                self.errorMessage = error.localizedDescription
//            }
//    }
//
//    func addItem(item: Item) {
//        repository.addItem(authToken: authToken, item: item, pharmacyId: currentReturnRequest.pharmacyId, returnRequestId: currentReturnRequest.id)
//            .done { newItem in
//                self.items.append(newItem)
//            }
//            .catch { error in
//                self.errorMessage = error.localizedDescription
//            }
//    }
//
//    func updateItem(itemId: String, updatedItem: Item) {
//        repository.updateItem(authToken: authToken, pharmacyId: currentReturnRequest.pharmacyId, returnRequestId: currentReturnRequest.id, itemId: itemId, updatedItem: updatedItem)
//            .done { newItem in
//                if let index = self.items.firstIndex(where: { $0.id == itemId }) {
//                    self.items[index] = newItem
//                }
//            }
//            .catch { error in
//                self.errorMessage = error.localizedDescription
//            }
//    }
}
