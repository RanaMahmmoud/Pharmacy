//
//  wholesalersView.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 20/07/2024.
//

import SwiftUI

struct WholesalerListView: View {
    @ObservedObject var viewModel: WholesalerViewModel
    var pharmacyId: Int
    @EnvironmentObject var loginViewModel: LoginViewModel
    @State private var showCreateReturnRequest = false
    var body: some View {
        VStack {
                  if viewModel.isLoading {
                      ProgressView("Loading Wholesalers...")
                  } else if !viewModel.errorMessage.isEmpty {
                      Text(viewModel.errorMessage)
                          .foregroundColor(.red)
                          .padding()
                  } else {
                      ScrollView {
                          VStack(spacing: 15) {
                              ForEach(viewModel.wholesalers) { wholesaler in
                                  WholesalerRowView(wholesaler: wholesaler, viewModel: viewModel, loginViewModel: loginViewModel, pharmacyId: pharmacyId)
                              }
                          }
                          .padding(.horizontal)
                      }
                  }
            
              }
              .navigationTitle("Wholesalers")
        .onAppear {
            viewModel.fetchWholesalers(authToken: loginViewModel.authToken, pharmacyId: pharmacyId)
        }
    }
}

struct WholesalerListView_Previews: PreviewProvider {
    static var previews: some View {
        WholesalerListView(viewModel: WholesalerViewModel(), pharmacyId: 1)
            .environmentObject(LoginViewModel())
    }
}


