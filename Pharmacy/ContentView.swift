//
//  ContentView.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 20/07/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var loginViewModel = LoginViewModel()
    @StateObject var returnRequestViewModel = ReturnRequestViewModel()
    @State private var selectedReturnRequest: ReturnRequest?

    var body: some View {
      //  if loginViewModel.isLoggedIn {
//            ReturnRequestView(viewModel: returnRequestViewModel, selectedReturnRequest: $selectedReturnRequest)
//                .onAppear {
//                    returnRequestViewModel.authToken = loginViewModel.authToken
//                }
//                .fullScreenCover(item: $selectedReturnRequest) { request in
//                    ItemView(viewModel: ItemViewModel(currentReturnRequest: request, authToken: loginViewModel.authToken))
//                }
//        } else {
            LoginView(viewModel: loginViewModel)
       // }
    }
}
