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
    @Published var isLoading = false
    @Published var isSucess = false
    @Published var errorMessage: String?
    @Published var index :Int?
    @Published var itemId:Int?
    let authToken: String
    let returnRequestId: Int
    let pharmacyId: Int
    private let apiManager = APIManager.shared
    private var cancellables = Set<AnyCancellable>()
    

    init(returnRequestId: Int,pharmacyId:Int, authToken: String) {
        self.returnRequestId = returnRequestId
        self.authToken = authToken
        self.pharmacyId = pharmacyId
    }
    func generateRandomID() -> Int {
        let length = 4
        let min = Int(pow(10.0, Double(length - 1)))
          let max = Int(pow(10.0, Double(length))) - 1
          return Int.random(in: min...max)
    }
    func fetchItems() {
        APIManager.shared.getItems(authToken: authToken, pharmacyId: pharmacyId, returnRequestId: returnRequestId)
        { result, error in
            if let error = error{
                self.errorMessage = error.localizedDescription
                self.isLoading = false
                self.isSucess = false
            }
            else{
                
                self.isLoading = false
                self.isSucess = true
            }
            self.isLoading = false
        }
    }
    func addItem(item: Item) {
        apiManager.addItem(authToken: authToken, item: item, pharmacyId: pharmacyId, returnRequestId: returnRequestId)
         
        { newItem, error in
            if let error = error{
                self.errorMessage = error.localizedDescription
                self.isLoading = false
                self.isSucess = false
                print(error)
            }
            else{
                self.items.append(item)
                self.isLoading = false
                self.isSucess = true
                print("Items Added")
            }
            self.isLoading = false
        }
    }

    func updateItem(itemId: Int, updatedItem: Item) {

            apiManager.updateItem(authToken: authToken, pharmacyId: pharmacyId, returnRequestId: returnRequestId, itemId: itemId, updatedItem: updatedItem)
            { newItem, error in
                if let error = error{
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                    self.isSucess = false
                    print(error)
                }
                else{
                    if let i = self.index {
                        self.items[i] = updatedItem
                    }
                    self.isLoading = false
                    self.isSucess = true
                    print("Items Updated")
                }
                self.isLoading = false
            }
        
    }
}
