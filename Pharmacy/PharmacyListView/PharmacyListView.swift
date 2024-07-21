//
//  PharmacyListView.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 20/07/2024.
//

import SwiftUI

struct PharmacyListView: View {
    @ObservedObject var viewModel: PharmacyListViewModel
    @EnvironmentObject var loginViewModel: LoginViewModel
    @State private var showBottomSheet = false
    @State private var selectedPharmacy: Pharmacy?
    @State private var destination: Destination?

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading Pharmacies...")
                } else if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(viewModel.pharmacies) { pharmacy in
                                PharmacyRowView(pharmacy: pharmacy)
                                    .onTapGesture {
                                        selectedPharmacy = pharmacy
                                        showBottomSheet.toggle()
                                    }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Pharmacies")
            .sheet(isPresented: $showBottomSheet) {
                 BottomSheetView(showBottomSheet: $showBottomSheet, pharmacy: $selectedPharmacy, destination: $destination)
                    .background(Color.black.opacity(0.1).edgesIgnoringSafeArea(.all))

            }
            .background(
                NavigationLink(
                    destination: destinationView(),
                    isActive: Binding<Bool>(
                        get: { destination != nil },
                        set: { _ in }
                    ),
                    label: { EmptyView() }
                )
            )
        }
        .onAppear {
            viewModel.fetchPharmacies(authToken: loginViewModel.authToken)
        }
    }
    
    @ViewBuilder
    private func destinationView() -> some View {
        if let destination = destination, let pharmacy = selectedPharmacy {
            switch destination {
            case .wholesalers:
                WholesalerListView(viewModel: WholesalerViewModel(), pharmacyId: pharmacy.pharmacyId ?? 0)
                    .environmentObject(loginViewModel)
            case .returnRequests:
             
               ListReturnRequestsView(viewModel:ListReturnRequestsViewModel(), pharmacyId: pharmacy.pharmacyId ?? 0)
                   .environmentObject(loginViewModel)
            }
        } else {
            EmptyView()
        }
    }
    
    enum Destination {
        case wholesalers
        case returnRequests
    }
}
