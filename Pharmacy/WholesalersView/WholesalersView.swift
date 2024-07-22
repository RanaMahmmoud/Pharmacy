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
    @Binding var showModal: Bool
    var body: some View {
        VStack {
            HStack {
                Button {
                    showModal.toggle()
                } label: {
                    Image(systemName: "chevron.left")
                }
                HStack {
                    Spacer()
                    
                    Text("Wholesalers")
                        .font(.system(size: 18, weight: .bold))
                    
                    Spacer()
                    
                }
                Spacer()
            }.padding(.vertical,25)
                .padding(.leading,25)
            
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
                                  WholesalerRowView(wholesaler: wholesaler, viewModel: viewModel, loginViewModel: loginViewModel, showCreateReturnRequest:$showCreateReturnRequest, pharmacyId: pharmacyId)
                              }
                          }
                          .padding(.horizontal)
                      }
                  }
            
              }
             
        .onAppear {
            viewModel.fetchWholesalers(authToken: loginViewModel.authToken, pharmacyId: pharmacyId)
        }
        .bottomSheet(isPresented: $showCreateReturnRequest, height: 400) {
 
            CreateReturnRequestView(viewModel: CreateReturnRequestViewModel(authToken: loginViewModel.authToken, pharmacyId: pharmacyId))
                        .environmentObject(viewModel)
                        
        }
    }
}



