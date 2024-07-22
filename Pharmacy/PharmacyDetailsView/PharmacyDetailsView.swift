// PharmacyDetailsView.swift
// Pharmacy
//
// Created by Rana Mahmoud on 21/07/2024.
//

import Foundation
import SwiftUI

struct PharmacyDetailsView: View {
    @ObservedObject var viewModel: PharmacyDetailsViewModel
    @EnvironmentObject var loginViewModel: LoginViewModel
    var pharmacyId: Int
    var authToken: String
    @Binding var showModal: Bool

    var body: some View {
        HStack {
            if viewModel.isLoading {
                ProgressView("Loading Pharmacy Details...")
            } else if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                VStack(alignment: .leading, spacing: 5) {
                    if let data = viewModel.pharmacyDetails?.pharmacy {
                        Text("Pharmacy ID: \(data.id)")
                            .font(.system(size: 16, weight: .semibold))

                        Text("Doing Business As: \(data.doingBusinessAs)")
                            .font(.system(size: 14))

                        Text("Legal Business Name: \(data.legalBusinessName)")
                            .font(.system(size: 14))

                        Text("Company Type: \(data.companyType)")
                            .font(.system(size: 14))

                        Text("Reimbursement Type: \(data.reimbursementType)")
                            .font(.system(size: 14))

                        Text("DEA: \(data.dea)")
                            .font(.system(size: 14))

                        Text("License State: \(data.licenseState)")
                            .font(.system(size: 14))

                        Text("License State Code: \(data.licenseStateCode)")
                            .font(.system(size: 14))

                        Text("NPI: \(data.npi)")
                            .font(.system(size: 14))

                        Text("Enabled: \(data.enabled ? "Yes" : "No")")
                            .font(.system(size: 14))
                            .foregroundColor(data.enabled ? .green : .red)

                        Text("Created At: \(data.createdAt ?? "")")
                            .font(.system(size: 14))

                        Text("Updated At: \(data.updatedAt ?? "N/A")")
                            .font(.system(size: 14))

                        Text("User Info:")
                            .font(.system(size: 16, weight: .semibold))

                        Text("Username: \(data.user.username ?? "")")
                            .font(.system(size: 14))

                        Text("Email: \(data.user.email ?? "")")
                            .font(.system(size: 14))

                        Text("Role: \(data.user.role ?? "")")
                            .font(.system(size: 14))

                        Text("Activated: \(data.user.activated ?? false ? "Yes" : "No")")
                            .font(.system(size: 14))
                            .foregroundColor(data.user.activated ?? false ? .green : .red)
                    }
                }
                Spacer()
            }
        }
        .onAppear() {
            viewModel.fetchPharmacyDetailsRequests(authToken: authToken, pharmacyId: pharmacyId)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
