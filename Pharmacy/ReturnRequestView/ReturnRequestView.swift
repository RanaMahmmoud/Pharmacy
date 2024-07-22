//
//  ReturnRequestView.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 20/07/2024.
//

import SwiftUI

struct ReturnRequestView: View {
    @ObservedObject var viewModel: ReturnRequestViewModel
    @EnvironmentObject var loginViewModel: LoginViewModel
    var pharmacyId: Int
    var requestId: Int
    var authToken: String
   
    
    var body: some View {
        
        HStack {
            if viewModel.isLoading {
                ProgressView("Loading Return Requests...")
            } else if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                VStack(alignment: .leading, spacing: 5) {
                    if let data = viewModel.returnRequest {
                        Text("ID: \(data.id ?? 0)")
                            .font(.system(size: 16, weight: .semibold))
                        
                        Text("Created At: \(data.createdAt ?? "")")
                            .font(.system(size: 14))
                        
                        Text("Items: \(data.pharmacy?.id ?? 0)")
                            .font(.system(size: 14))
                        
                        Text("Status: \(data.returnRequestStatusLabel)")
                            .font(.system(size: 14))
                        
                        Text("Service Type: \(data.serviceType)")
                            .font(.system(size: 14))
                        
                        Text("Associated Wholesaler: \(data.pharmacy?.doingBusinessAs ?? "")")
                            .font(.system(size: 14))
                        
                    }
                }
                Spacer()
            }
            }
        .onAppear(){
            viewModel.fetchReturnRequests(authToken: authToken, pharmacyId: pharmacyId, requestId: requestId)
        }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
        
          
       }
   }

