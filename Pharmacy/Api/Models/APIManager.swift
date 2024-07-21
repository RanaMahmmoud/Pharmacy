//
//  APIMAnager.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 20/07/2024.
//

import Foundation
import PromiseKit

class APIManager {
    
    static let shared = APIManager()
    
    private let pharmacyRepository = PharmacyRepository()
    
    private init() { }
    
    func login(username: String, password: String, completion: @escaping (String?, Error?) -> Void) {
        pharmacyRepository.login(username: username, password: password).done { token in
            completion(token, nil)
        }.catch { error in
            completion(nil, error)
        }
    }
    
    func getPharmacies(authToken: String, completion: @escaping ([Pharmacy]?, Error?) -> Void) {
        pharmacyRepository.getPharmacies(accessToken: authToken).done { pharmacies in
            completion(pharmacies, nil)
        }.catch { error in
            completion(nil, error)
        }
    }

    func getWholesalers(authToken: String, pharmacyId: Int, completion: @escaping ([Wholesaler]?, Error?) -> Void) {
        pharmacyRepository.getWholesalers(authToken: authToken, pharmacyId: pharmacyId).done { wholesalers in
            completion(wholesalers, nil)
        }.catch { error in
            completion(nil, error)
        }
    }

    func createReturnRequest(authToken: String, pharmacyId: Int, serviceType: String, wholesalerId: Int, completion: @escaping (ReturnRequest?, Error?) -> Void) {
        pharmacyRepository.createReturnRequest(authToken: authToken, pharmacyId: pharmacyId, serviceType: serviceType, wholesalerId: wholesalerId).done { request in
            completion(request, nil)
        }.catch { error in
            completion(nil, error)
        }
    }

    func getListReturnRequests(authToken: String, pharmacyId: Int, completion: @escaping (ListReturn?, Error?) -> Void) {
        pharmacyRepository.getListReturnRequests(authToken: authToken, pharmacyId: pharmacyId).done { request in
            completion(request, nil)
        
        }.catch { error in
            completion(nil, error)
        }
    }
    func getReturnRequests(authToken: String, pharmacyId: Int, requestId : Int ,completion: @escaping (ReturnRequest?, Error?) -> Void) {
        pharmacyRepository.getReturnRequests(authToken: authToken, pharmacyId: pharmacyId , requestId : requestId).done { requests in
            completion(requests, nil)
        }.catch { error in
            completion(nil, error)
        }
    }

    func addItem(authToken: String, item: Item, pharmacyId: String, returnRequestId: String, completion: @escaping (Item?, Error?) -> Void) {
        pharmacyRepository.addItem(authToken: authToken, item: item, pharmacyId: pharmacyId, returnRequestId: returnRequestId).done { item in
            completion(item, nil)
        }.catch { error in
            completion(nil, error)
        }
    }

    func getItems(authToken: String, pharmacyId: String, returnRequestId: String, completion: @escaping ([Item]?, Error?) -> Void) {
        pharmacyRepository.getItems(authToken: authToken, pharmacyId: pharmacyId, returnRequestId: returnRequestId).done { items in
            completion(items, nil)
        }.catch { error in
            completion(nil, error)
        }
    }

    func updateItem(authToken: String, pharmacyId: String, returnRequestId: String, itemId: String, updatedItem: Item, completion: @escaping (Item?, Error?) -> Void) {
        pharmacyRepository.updateItem(authToken: authToken, pharmacyId: pharmacyId, returnRequestId: returnRequestId, itemId: itemId, updatedItem: updatedItem).done { item in
            completion(item, nil)
        }.catch { error in
            completion(nil, error)
        }
    }

    func deleteItem(authToken: String, pharmacyId: String, returnRequestId: String, itemId: String, completion: @escaping (Bool?, Error?) -> Void) {
        pharmacyRepository.deleteItem(authToken: authToken, pharmacyId: pharmacyId, returnRequestId: returnRequestId, itemId: itemId).done { success in
            completion(success, nil)
        }.catch { error in
            completion(nil, error)
        }
    }
}
