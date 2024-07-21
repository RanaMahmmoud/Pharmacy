//
//  LoginViewModel.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 20/07/2024.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var authToken: String = ""
    @Published var errorMessage: String = ""
    @Published var isLoading = false
    
    // Other properties and methods

      var hasError: Bool {
          !errorMessage.isEmpty
      }
    private var cancellables = Set<AnyCancellable>()

    func login() {
        isLoading = true
        APIManager.shared.login(username: username, password: password) { [weak self] token, error in
            if let token = token {
                self?.authToken = token
                self?.isLoggedIn = true
            } else {
                self?.errorMessage = error?.localizedDescription ?? "Unknown error"
            }
            self?.isLoading = false
        }
    }
}
