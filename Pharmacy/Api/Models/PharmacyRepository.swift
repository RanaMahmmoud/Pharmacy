//
//  PharmacyRepository.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 20/07/2024.
//

import Foundation
import PromiseKit
import Alamofire

enum APIError: Error {
    case signInError
}

class PharmacyRepository {
      var getPharmaciesRequest: DataRequest?
    
    
        func login(username: String, password: String) -> Promise<String> {
            return Promise { seal in
                let parameters: [String: Any] = ["username": username, "password": password]
                var request = URLRequest(url: URL(string: LoginURL)!)
                request.httpMethod = HTTPMethod.post.rawValue
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                } catch let error {
                    seal.reject(error)
                    return
                }
                
                AF.request(request)
                    .responseDecodable(of: LoginResponse.self) { response in
                        switch response.result {
                        case .success(let data):
                            print("Pharamacy-Log: getAccessToken: reponseJSON: success \(data.token)")
                            seal.fulfill(data.token)
                        case .failure(let error):
                            seal.reject(error)
                        }
                    }
            }
        }




    func getPharmacies(authToken: String) -> Promise<[Pharmacy]> {
        return Promise { seal in
            let headers: HTTPHeaders = ["Authorization": "Bearer \(authToken)"]
            AF.request(getPharmaciesURL, method: .get, headers: headers)
                .responseDecodable(of: [Pharmacy].self) { response in
                    switch response.result {
                    case .success(let data):
                        seal.fulfill(data)
                    case .failure(let error):
                        seal.reject(error)
                    }
                }
        }
    }
    func getPharmacies(accessToken: String) -> Promise<[Pharmacy]> {

           return Promise() { resolver in
               let headers: HTTPHeaders = ["Authorization": "Bearer \(accessToken)"]
            
               do {
                   AF.request(getPharmaciesURL, method: .get, headers: headers).response { response in
                       switch response.result {
                       case .success:
                           if let data = response.data {
                               self.getPharmaciesRequest = nil
                               do {
                                   print("\(response.response?.statusCode)")
                                   let reponseJSON = try JSONDecoder().decode([Pharmacy].self, from: response.data!)
                                   resolver.fulfill(reponseJSON)
                                   print("Pharamacy-Log: getPharamacyList: reponseJSON: success")
                               } catch (let error) {
                                   print("Pharamacy-Log: getPharamacyList: Error reponseJSON \(error)")
                                   resolver.reject(error)
                               }
                           }
                       case .failure(let error):
                           self.getPharmaciesRequest = nil
                           print("Pharamacy-Log: getPharmaciesListRequest: Error = \(error.localizedDescription)")
                           resolver.reject(error)
                       }
                   }
               }catch {
                   print(error.localizedDescription)

               }
          
           }
       }
    func getWholesalers(authToken: String, pharmacyId: Int) -> Promise<[Wholesaler]> {
           return Promise { seal in
               let headers: HTTPHeaders = ["Authorization": "Bearer \(authToken)"]
               AF.request("\(baseURL)pharmacies/\(pharmacyId)/wholesalers", method: .get, headers: headers)
                   .response { response in
                       switch response.result {
                       case .success:
                           if let data = response.data {
                               do {
                                   print("\(response.response?.statusCode)")
                                   let reponseJSON = try JSONDecoder().decode([Wholesaler].self, from: response.data!)
                                   seal.fulfill(reponseJSON)
                                   print("Pharamacy-Log: getWholesalers: reponseJSON: success")
                               } catch (let error) {
                                   print("Pharamacy-Log: getWholesalers: Error reponseJSON \(error)")
                                   seal.reject(error)
                               }
                           }
                       case .failure(let error):
                       
                           print("Pharamacy-Log: getWholesalers: Error = \(error.localizedDescription)")
                           seal.reject(error)
                       }
                   }
           }
       }

       func createReturnRequest(authToken: String, pharmacyId: Int, serviceType: String, wholesalerId: Int) -> Promise<ReturnRequest> {
           return Promise { seal in
               let headers: HTTPHeaders = ["Authorization": "Bearer \(authToken)"]
               let parameters: [String: Any] = ["serviceType": serviceType, "wholesalerId": wholesalerId]
               AF.request("\(baseURL)pharmacies/\(pharmacyId)/returnrequests", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                   .response { response in
                       switch response.result {
                       case .success:
                           if let data = response.data {
                               do {
                                   print("\(response.response?.statusCode)")
                                   let reponseJSON = try JSONDecoder().decode(ReturnRequest.self, from: response.data!)
                                   seal.fulfill(reponseJSON)
                                   print("Pharamacy-Log: ReturnRequest: reponseJSON: success")
                               } catch (let error) {
                                   print("Pharamacy-Log: ReturnRequest: Error reponseJSON \(error)")
                                   seal.reject(error)
                               }
                           }
                       case .failure(let error):
                       
                           print("Pharamacy-Log: getWholesalers: Error = \(error.localizedDescription)")
                           seal.reject(error)
                       }
                   }
                 
           }
       }

    func getListReturnRequests(authToken: String, pharmacyId: Int) -> Promise<ListReturn> {
        return Promise { seal in
            let headers: HTTPHeaders = ["Authorization": "Bearer \(authToken)"]
            AF.request("\(baseURL)pharmacies/\(pharmacyId)/returnrequests", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .response { response in
                    switch response.result {
                    case .success:
                        if let data = response.data {
                            do {
                                print("\(response.response?.statusCode)")
                                let reponseJSON = try JSONDecoder().decode(ListReturn.self, from: response.data!)
                                seal.fulfill(reponseJSON)
                                print("Pharamacy-Log: getListReturnRequests: reponseJSON: success")
                            } catch (let error) {
                                print("Pharamacy-Log: getListReturnRequests: Error reponseJSON \(error)")
                                seal.reject(error)
                            }
                        }
                    case .failure(let error):
                    
                        print("Pharamacy-Log: getListReturnRequests: Error = \(error.localizedDescription)")
                        seal.reject(error)
                    }
                }
        }
    }
    func getReturnRequests(authToken: String, pharmacyId: Int , requestId : Int) -> Promise<ReturnRequest> {
        print("Pharamacy-Log: getReturnRequests")
        return Promise { seal in
            let headers: HTTPHeaders = ["Authorization": "Bearer \(authToken)"]
            AF.request("\(baseURL)pharmacies/\(pharmacyId)/returnrequests/\(requestId)", method: .get, headers: headers)
                .response { response in
                    switch response.result {
                    case .success:
                        if let data = response.data {
                            do {
                                print("\(response.response?.statusCode)")
                                let reponseJSON = try JSONDecoder().decode(ReturnRequest.self, from: response.data!)

                                seal.fulfill(reponseJSON)
                                print("Pharamacy-Log: getReturnRequests: reponseJSON: success \(reponseJSON)")

                            } catch (let error) {
                                print("Pharamacy-Log: getReturnRequests: Error reponseJSON \(error)")
                                seal.reject(error)
                            }
                        }
                    case .failure(let error):
                    
                        print("Pharamacy-Log: getReturnRequests: Error = \(error.localizedDescription)")
                        seal.reject(error)
                    }
                }        }
    }

    func addItem(authToken: String, item: Item, pharmacyId: String, returnRequestId: String) -> Promise<Item> {
        return Promise { seal in
            let headers: HTTPHeaders = ["Authorization": "Bearer \(authToken)"]
            let parameters: [String: Any] = [
                "ndc": item.ndc,
                "description": item.description,
                "manufacturer": item.manufacturer,
                "fullQuantity": item.fullQuantity,
                "partialQuantity": item.partialQuantity,
                "expirationDate": item.expirationDate,
                "lotNumber": item.lotNumber
            ]
            AF.request("\(baseURL)rxmax/pharmacies/\(pharmacyId)/returnrequests/\(returnRequestId)/items", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .responseDecodable(of: Item.self) { response in
                    switch response.result {
                    case .success(let data):
                        seal.fulfill(data)
                    case .failure(let error):
                        seal.reject(error)
                    }
                }
        }
    }

    func getItems(authToken: String, pharmacyId: String, returnRequestId: String) -> Promise<[Item]> {
        return Promise { seal in
            let headers: HTTPHeaders = ["Authorization": "Bearer \(authToken)"]
            AF.request("\(baseURL)rxmax/pharmacies/\(pharmacyId)/returnrequests/\(returnRequestId)/items", method: .get, headers: headers)
                .responseDecodable(of: [Item].self) { response in
                    switch response.result {
                    case .success(let data):
                        seal.fulfill(data)
                    case .failure(let error):
                        seal.reject(error)
                    }
                }
        }
    }

    func updateItem(authToken: String, pharmacyId: String, returnRequestId: String, itemId: String, updatedItem: Item) -> Promise<Item> {
        return Promise { seal in
            let headers: HTTPHeaders = ["Authorization": "Bearer \(authToken)"]
            let parameters: [String: Any] = [
                "ndc": updatedItem.ndc,
                "description": updatedItem.description,
                "manufacturer": updatedItem.manufacturer,
                "fullQuantity": updatedItem.fullQuantity,
                "partialQuantity": updatedItem.partialQuantity,
                "expirationDate": updatedItem.expirationDate,
                "lotNumber": updatedItem.lotNumber
            ]
            AF.request("\(baseURL)pharmacies/\(pharmacyId)/returnrequests/\(returnRequestId)/items/\(itemId)", method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .responseDecodable(of: Item.self) { response in
                    switch response.result {
                    case .success(let data):
                        seal.fulfill(data)
                    case .failure(let error):
                        seal.reject(error)
                    }
                }
        }
    }

    func deleteItem(authToken: String, pharmacyId: String, returnRequestId: String, itemId: String) -> Promise<Bool> {
        return Promise { seal in
            let headers: HTTPHeaders = ["Authorization": "Bearer \(authToken)"]
            AF.request("\(baseURL)pharmacies/\(pharmacyId)/returnrequests/\(returnRequestId)/items/\(itemId)", method: .delete, headers: headers)
                .response { response in
                    switch response.result {
                    case .success:
                        seal.fulfill(true)
                    case .failure(let error):
                        seal.reject(error)
                    }
                }
        }
    }
}