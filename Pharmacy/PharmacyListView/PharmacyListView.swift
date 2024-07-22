//
//  PharmacyListView.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 20/07/2024.
//

import SwiftUI
import BottomSheet

struct PharmacyListView: View {
    @ObservedObject var viewModel: PharmacyListViewModel
    @EnvironmentObject var loginViewModel: LoginViewModel
    @State private var showBottomSheet = false
    @State private var destination: Destination?
    @State private var isPresentedWholesalerListView: Bool = false
    @State private var isPresentedListReturnRequestsView: Bool = false
    @State private var isPresentedReturnRequestView: Bool = false
    var body: some View {
//        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    
                    Text("Pharmacies")
                        .font(.system(size: 18, weight: .bold))
                    
                    Spacer()
                    
                }.padding(.bottom,25)
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
                                PharmacyRowView(pharmacy: pharmacy ,showBottomSheet : $showBottomSheet )
                                    .environmentObject(viewModel)
                                    .onTapGesture {
                                        viewModel.selectedParamacy = pharmacy
                                    }

                            }
                        }
                        .padding(.horizontal)
                    }.padding(.top,10)
                }
            }.bottomSheet(isPresented: $isPresentedReturnRequestView, height: 500) {
             
                if(isPresentedReturnRequestView){
                    PharmacyDetailsView(viewModel: PharmacyDetailsViewModel(), pharmacyId: viewModel.selectedParamacy?.pharmacyId ?? 0 ,authToken: loginViewModel.authToken, showModal: $isPresentedReturnRequestView)
                    
                }
            }
                
            .bottomSheet(isPresented: $showBottomSheet, height: 300) {
                if(showBottomSheet){
                    BottomSheetView(showBottomSheet: $showBottomSheet, destination: $destination ,isPresentedWholesalerListView: $isPresentedWholesalerListView,isPresentedListReturnRequestsView:$isPresentedListReturnRequestsView, isPresentedReturnRequestView: $isPresentedReturnRequestView)
                }

        }
        .fullScreenCover(isPresented: $isPresentedWholesalerListView, content: {
            if let pharmacy = viewModel.selectedParamacy {
                WholesalerListView(viewModel: WholesalerViewModel(), pharmacyId: pharmacy.pharmacyId ?? 0,showModal: $isPresentedWholesalerListView)
                    .environmentObject(loginViewModel)
            }
        })
        .fullScreenCover(isPresented: $isPresentedListReturnRequestsView, content: {
            if let pharmacy = viewModel.selectedParamacy {
                ListReturnRequestsView(viewModel:ListReturnRequestsViewModel(), pharmacyId: pharmacy.pharmacyId ?? 0, showModal: $isPresentedListReturnRequestsView)
                    .environmentObject(loginViewModel)
            }
           
        })
      
        .onAppear {
            viewModel.fetchPharmacies(authToken: loginViewModel.authToken)
        }
      
        
    }
    
  
    enum Destination {
        case wholesalers
        case returnRequests
    }
}
