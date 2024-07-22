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
        Task {
            pharmacyRepository.login(username: username, password: password).done { token in
                completion(token, nil)
            }.catch { error in
                completion(nil, error)
            }
        }
    }
    
    func getPharmacies(authToken: String, completion: @escaping ([Pharmacy]?, Error?) -> Void) {
        Task {
            pharmacyRepository.getPharmacies(accessToken: authToken).done { pharmacies in
                completion(pharmacies, nil)
            }.catch { error in
                completion(nil, error)
            }
        }
    }

    func getWholesalers(authToken: String, pharmacyId: Int, completion: @escaping ([Wholesaler]?, Error?) -> Void) {
        Task {
            pharmacyRepository.getWholesalers(authToken: authToken, pharmacyId: pharmacyId).done { wholesalers in
                completion(wholesalers, nil)
            }.catch { error in
                completion(nil, error)
            }
        }
    }

    func createReturnRequest(authToken: String, pharmacyId: Int, serviceType: String, wholesalerId: Int, completion: @escaping (ReturnRequest?, Error?) -> Void) {
        Task {
            pharmacyRepository.createReturnRequest(authToken: authToken, pharmacyId: pharmacyId, serviceType: serviceType, wholesalerId: wholesalerId).done { request in
                completion(request, nil)
            }.catch { error in
                completion(nil, error)
            }
        }
    }

    func getListReturnRequests(authToken: String, pharmacyId: Int, completion: @escaping (ListReturn?, Error?) -> Void) {
        Task {
            pharmacyRepository.getListReturnRequests(authToken: authToken, pharmacyId: pharmacyId).done { request in
                completion(request, nil)
                
            }.catch { error in
                completion(nil, error)
            }
        }
    }
    func getReturnRequests(authToken: String, pharmacyId: Int, requestId : Int ,completion: @escaping (ReturnRequest?, Error?) -> Void) {
        Task {
            pharmacyRepository.getReturnRequests(authToken: authToken, pharmacyId: pharmacyId , requestId : requestId).done { requests in
                completion(requests, nil)
            }.catch { error in
                completion(nil, error)
            }
        }
    }
    func getPharmacyDetailsRequests(authToken: String, pharmacyId: Int ,completion: @escaping (PharmacyResponse?, Error?) -> Void) {
        Task {
            pharmacyRepository.getPharamacyDetailsRequests(authToken: authToken, pharmacyId: pharmacyId).done { requests in
                completion(requests, nil)
            }.catch { error in
                completion(nil, error)
            }
        }
    }
    func addItem(authToken: String, item: Item, pharmacyId: Int, returnRequestId: Int, completion: @escaping (Bool?, Error?) -> Void) {
        Task {
            pharmacyRepository.addItem(authToken: authToken, item: item, pharmacyId: pharmacyId, returnRequestId: returnRequestId).done { item in
                completion(item, nil)
            }.catch { error in
                completion(nil, error)
            }
        }
    }

    func getItems(authToken: String, pharmacyId: Int, returnRequestId: Int, completion: @escaping ([Item]?, Error?) -> Void) {
        Task {
            pharmacyRepository.getItems(authToken: authToken, pharmacyId: pharmacyId, returnRequestId: returnRequestId).done { items in
                completion(items, nil)
            }.catch { error in
                completion(nil, error)
            }
        }
    }

    func updateItem(authToken: String, pharmacyId: Int, returnRequestId: Int, itemId: Int, updatedItem: Item, completion: @escaping (Bool?, Error?) -> Void) {
        Task {
            pharmacyRepository.updateItem(authToken: authToken, pharmacyId: pharmacyId, returnRequestId: returnRequestId, itemId: itemId, updatedItem: updatedItem).done { item in
                completion(item, nil)
            }.catch { error in
                completion(nil, error)
            }
        }
    }

    func deleteItem(authToken: String, pharmacyId: Int, returnRequestId: Int, itemId: Int, completion: @escaping (Bool?, Error?) -> Void) {
        Task {
            pharmacyRepository.deleteItem(authToken: authToken, pharmacyId: pharmacyId, returnRequestId: returnRequestId, itemId: itemId).done { success in
                completion(success, nil)
            }.catch { error in
                completion(nil, error)
            }
        }
    }
}
