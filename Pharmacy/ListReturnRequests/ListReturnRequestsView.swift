//
//  ListReturnRequestsView.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 21/07/2024.
//

import SwiftUI

struct ListReturnRequestsView: View {
    @ObservedObject var viewModel: ListReturnRequestsViewModel
    @EnvironmentObject var loginViewModel: LoginViewModel
    let pharmacyId: Int
    @State private var showReturnRequest = false
    @State private var selectedRequest:ReturnRequestData?
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading Return Requests...")
                } else if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(viewModel.returnRequests) { returnRequest in
                                if let requestData = returnRequest.returnRequest {
                                    ListReturnRequestsRow(returnRequest: requestData)
                                        .onTapGesture {
                                            
                                        selectedRequest = requestData
                                      
                                        showReturnRequest = true
                                       
                                    }

                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Return Requests")
            
            .sheet(isPresented: $showReturnRequest) {
             if let data = selectedRequest
                {
                 ReturnRequestView(viewModel: ReturnRequestViewModel(), pharmacyId: pharmacyId, requestId:  data.id ?? 0 ,authToken: loginViewModel.authToken)

                 
             }
            }
        }.onAppear {
            viewModel.fetchReturnRequests(authToken: loginViewModel.authToken, pharmacyId: pharmacyId)
        }
    }
}

