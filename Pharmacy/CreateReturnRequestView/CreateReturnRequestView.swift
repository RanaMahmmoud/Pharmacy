//
//  CreateReturnRequestView.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 20/07/2024.
//

import SwiftUI

struct CreateReturnRequestView: View {
    @ObservedObject var viewModel: CreateReturnRequestViewModel
    @State private var selectedServiceType = "EXPRESS_SERVICE"
    @State private var selectedWholesaler = 0

    var body: some View {
        VStack {
            Text("Create Your Return Request")
                .font(.title)
                .fontWeight(.bold)
             
            Picker("Service Type", selection: $selectedServiceType) {
                Text("EXPRESS_SERVICE").tag("EXPRESS_SERVICE")
                Text("FULL_SERVICE").tag("FULL_SERVICE")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Picker("Wholesaler", selection: $selectedWholesaler) {
                ForEach(viewModel.wholesalers, id: \.id) { wholesaler in
                    Text(wholesaler.name).tag(wholesaler.id)
                }
            }
            .padding()

            Button(action: {
                viewModel.createReturnRequest(serviceType: selectedServiceType, wholesalerId: selectedWholesaler)
            }) {
                Text("Create Return Request")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.vertical)
                .frame(width: UIScreen.main.bounds.width - 30)
        }
        .background(Color.blue)
        .cornerRadius(6)
            
            .padding()

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .toast(isPresenting: $viewModel.isCreated) {
            AlertToast(type: .complete(Color.green) , title: "Success")
        }
        .toast(isPresenting: $viewModel.isFailed) {
            AlertToast(type: .error(Color.red) , title: "Fail")
        }
        .onAppear {
            viewModel.fetchWholesalers()
        }
        
        .navigationTitle("Create Return Request")
    }
}
