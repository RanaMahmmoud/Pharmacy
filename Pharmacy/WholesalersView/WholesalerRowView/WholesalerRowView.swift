//
//  WholesalerRowView.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 20/07/2024.
//

import SwiftUI

struct WholesalerRowView: View {
    var wholesaler: Wholesaler
    @ObservedObject var viewModel: WholesalerViewModel
    @ObservedObject var loginViewModel: LoginViewModel
    @State private var showCreateReturnRequest = false
    var pharmacyId: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image("listicon") // Placeholder image name
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .padding(.trailing, 10)

                VStack(alignment: .leading) {
                    Text(wholesaler.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)

                    Text("Account Number: \(wholesaler.accountNumber ?? "N/A")")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding(.bottom, 10)

            VStack(alignment: .leading, spacing: 5) {
                ForEach(wholesaler.pharmaciesLinks, id: \.self) { link in
                    Text("Address: \(link.address), \(link.city), \(link.state) \(link.zipCode)")
                        .font(.subheadline)
                        .foregroundColor(.black)

                    Text("Primary: \(link.primary ? "Yes" : "No")")
                        .font(.subheadline)
                        .foregroundColor(link.primary ? .green : .red)
                }
            }
            Button(action: {
                showCreateReturnRequest.toggle()
            }) {
                Text("Create Return Request")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
        .sheet(isPresented: $showCreateReturnRequest) {
            CreateReturnRequestView(viewModel: CreateReturnRequestViewModel(authToken: loginViewModel.authToken, pharmacyId: pharmacyId))
                        .environmentObject(loginViewModel)
        }
    }
}
